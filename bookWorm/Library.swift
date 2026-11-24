//
//  ContentView.swift
//  BookWormTrials
//
//  Created by Sarah Chang on 7/19/26.
//

import SwiftUI
import PhotosUI

struct Library: View {
    @AppStorage("saved_books") private var books: [Book] = []
    
    @State private var showingAddBook: Bool = false
    @State private var selectedBookForEdit: Book? = nil

    @State private var bookTitle: String = ""
    @State private var bookAuthor: String = ""
    @State private var bookRating: Double = 0.0
    @State private var bookReview: String = ""
    @State private var bookSuggestions: [GoogleBookSuggestion] = []
    @State private var bookSuggestionMessage: String? = nil
    @State private var isSearchingBookSuggestions: Bool = false
    @State private var selectedSuggestionTitle: String = ""
    @State private var coverImageData: Data? = nil
    @State private var coverImageURL: URL? = nil
    @State private var selectedCoverPhotoItem: PhotosPickerItem? = nil
    @State private var suggestionSearchTask: Task<Void, Never>? = nil
    @State private var formResetTask: Task<Void, Never>? = nil
    
    private let formResetDelay: Duration = .milliseconds(550)
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("My Library")
                    .font(.custom("Gaegu-Bold", size: 52))
                    .foregroundStyle(Color.textColor)
                    .padding(.top, 8)
                
                NavigationStack {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(books) { book in
                                BookView(
                                    book: book,
                                    onEdit: { prepareEdit(for: book) }
                                )
                            }
                        }
                        .padding(.vertical)
                    }
                    .background(Color.background.ignoresSafeArea())
                }
                
                Button(action: {
                    prepareNewBook()
                }) {
                    Label("Add Book", systemImage: "plus")
                        .font(.custom("Gaegu-Regular", size: 28))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .foregroundStyle(Color.textColor)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.blue)
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
        }
        .overlay {
            if showingAddBook || selectedBookForEdit != nil {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture { dismissAndReset() }
                    
                    VStack(spacing: 0) {
                        Text(selectedBookForEdit == nil ? "New Book Entry" : "Edit Entry")
                            .font(.custom("Gaegu-Bold", size: 28))
                            .bold()
                            .padding(.bottom, 12)
                        
                        ScrollView {
                            VStack(spacing: 16) {
                                HStack(alignment: .top, spacing: 16) {
                                    VStack(spacing: 8) {
                                        coverPreview

                                        PhotosPicker(selection: $selectedCoverPhotoItem, matching: .images) {
                                            Label("Change", systemImage: "photo")
                                                .font(.custom("Gaegu-Regular", size: 16))
                                        }
                                        .buttonStyle(.bordered)
                                        .tint(Color.blue)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        VStack(alignment: .leading, spacing: 2) {
                                            TextField("Title:", text: $bookTitle)
                                                .textFieldStyle(.roundedBorder)
                                                .font(.custom("Gaegu-Regular", size: 20))
                                                .onChange(of: bookTitle) { _, newTitle in
                                                    queueBookSuggestionSearch(for: newTitle)
                                                }
                                            
                                            if shouldShowBookSuggestionPopup {
                                                bookSuggestionPopup
                                            }
                                        }
                                        
                                        TextField("Author:", text: $bookAuthor)
                                            .textFieldStyle(.roundedBorder)
                                            .font(.custom("Gaegu-Regular", size: 20))
                                        
                                        Text(bookRating == 0 ? "Tap to Rate" : "Rating: \(formatRating(bookRating))")
                                            .font(.custom("Gaegu-Regular", size: 15))
                                            .foregroundColor(.secondary)
                                        
                                        RatingView(rating: $bookRating)
                                    }
                                }
                                
                                ZStack(alignment: .topLeading) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(uiColor: .systemGray6))
                                    
                                    TextField("Review...", text: $bookReview, axis: .vertical)
                                        .padding(8)
                                        .multilineTextAlignment(.leading)
                                        .font(.custom("Gaegu-Regular", size: 18))
                                }
                                .frame(height: 140)
                            }
                            .padding(.bottom, 8)
                        }
                        
                        // Pinned Bottom Actions
                        HStack {
                            Button("Cancel") {
                                dismissAndReset()
                            }
                            .foregroundColor(Color.pink)
                            .font(.custom("Gaegu-Regular", size: 22))
                            
                            Spacer()
                            
                            Button(selectedBookForEdit == nil ? "Add Book" : "Save Changes") {
                                saveBook()
                            }
                            .font(.custom("Gaegu-Regular", size: 22))
                            .disabled(bookTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                        }
                        .padding(.top, 8)
                    }
                    .padding(20)
                    .frame(maxHeight: 620)
                    .background(Color.background, in: RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .padding(.horizontal, 20)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.55, dampingFraction: 0.9), value: showingAddBook || selectedBookForEdit != nil)
        .onChange(of: selectedCoverPhotoItem) { _, newItem in
            Task {
                await loadCoverImage(from: newItem)
            }
        }
    }

    private var coverPreview: some View {
        ZStack {
            if let coverImageData,
               let uiImage = UIImage(data: coverImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else if let coverImageURL {
                AsyncImage(url: coverImageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        placeholderCoverIcon
                    case .empty:
                        ProgressView()
                    @unknown default:
                        placeholderCoverIcon
                    }
                }
                .id(coverImageURL) // Ensures AsyncImage reloads immediately when URL changes
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                    placeholderCoverIcon
                }
            }
        }
        .frame(width: 80, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.blue.opacity(0.7), lineWidth: 1)
        }
    }
    
    private var placeholderCoverIcon: some View {
        Image(systemName: "book.closed")
            .font(.title)
            .foregroundColor(.secondary)
    }
    
    private var bookSuggestionPopup: some View {
        VStack(spacing: 0) {
            if isSearchingBookSuggestions {
                HStack(spacing: 10) {
                    ProgressView()
                    Text("Searching books...")
                        .font(.custom("Gaegu-Regular", size: 16))
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                .padding(10)
            } else if let bookSuggestionMessage {
                Text(bookSuggestionMessage)
                    .font(.custom("Gaegu-Regular", size: 16))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(bookSuggestions) { suggestion in
                            Button {
                                selectBookSuggestion(suggestion)
                            } label: {
                                HStack(spacing: 8) {
                                    suggestionThumbnail(for: suggestion)
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(suggestion.title)
                                            .font(.custom("Gaegu-Regular", size: 18))
                                            .lineLimit(1)
                                        
                                        Text(suggestion.author.isEmpty ? "Unknown author" : suggestion.author)
                                            .font(.custom("Gaegu-Regular", size: 14))
                                            .foregroundStyle(.secondary)
                                            .lineLimit(1)
                                    }
                                    Spacer()
                                }
                                .foregroundStyle(Color.textColor)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                                .background(Color.white)
                            }
                            
                            if suggestion.id != bookSuggestions.last?.id {
                                Divider()
                            }
                        }
                    }
                }
            }
        }
        .frame(height: 160)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.blue.opacity(0.7), lineWidth: 1)
        }
        .shadow(radius: 5, y: 3)
    }
    
    private var shouldShowBookSuggestionPopup: Bool {
        isSearchingBookSuggestions || bookSuggestionMessage != nil || !bookSuggestions.isEmpty
    }
    
    private func suggestionThumbnail(for suggestion: GoogleBookSuggestion) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.25))
            
            if let thumbnailURL = suggestion.thumbnailURL {
                AsyncImage(url: thumbnailURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    default:
                        Image(systemName: "book.closed")
                            .foregroundStyle(.secondary)
                    }
                }
                .id(thumbnailURL)
            } else {
                Image(systemName: "book.closed")
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 28, height: 40)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
    
    private func prepareNewBook() {
        cancelPendingFormReset()
        resetBookForm()
        showingAddBook = true
    }
    
    private func prepareEdit(for book: Book) {
        cancelPendingFormReset()
        resetBookForm()
        selectedBookForEdit = book
        bookTitle = book.title
        bookAuthor = book.author
        bookRating = book.rating
        bookReview = book.review
        coverImageURL = book.coverImageURL
        
        if let filename = book.imageFileName {
            coverImageData = BookImageManager.loadImage(named: filename)
        }
    }
    
    private func saveBook() {
        var savedFileName = selectedBookForEdit?.imageFileName

        if let coverImageData {
            if let oldFileName = savedFileName {
                BookImageManager.deleteImage(named: oldFileName)
            }
            savedFileName = BookImageManager.saveImage(coverImageData)
        }

        if let existingBook = selectedBookForEdit,
           let index = books.firstIndex(where: { $0.id == existingBook.id }) {
            books[index] = Book(
                id: existingBook.id,
                title: bookTitle,
                author: bookAuthor,
                rating: bookRating,
                review: bookReview,
                imageName: existingBook.imageName,
                imageFileName: savedFileName,
                coverImageURL: coverImageURL
            )
        } else {
            let newBook = Book(
                title: bookTitle,
                author: bookAuthor,
                rating: bookRating,
                review: bookReview,
                imageName: "book.fill",
                imageFileName: savedFileName,
                coverImageURL: coverImageURL
            )
            books.insert(newBook, at: 0)
        }
         
        dismissAndReset()
    }
    
    private func dismissAndReset() {
        showingAddBook = false
        selectedBookForEdit = nil
        suggestionSearchTask?.cancel()
        suggestionSearchTask = nil
        
        formResetTask?.cancel()
        formResetTask = Task {
            try? await Task.sleep(for: formResetDelay)
            guard !Task.isCancelled else { return }
            await MainActor.run {
                resetBookForm()
                formResetTask = nil
            }
        }
    }
    
    private func cancelPendingFormReset() {
        formResetTask?.cancel()
        formResetTask = nil
    }
    
    private func resetBookForm() {
        bookTitle = ""
        bookAuthor = ""
        bookRating = 0.0
        bookReview = ""
        bookSuggestions = []
        bookSuggestionMessage = nil
        isSearchingBookSuggestions = false
        selectedSuggestionTitle = ""
        coverImageData = nil
        coverImageURL = nil
        selectedCoverPhotoItem = nil
        suggestionSearchTask?.cancel()
        suggestionSearchTask = nil
    }
    
    private func formatRating(_ rating: Double) -> String {
        rating.formatted(.number.precision(.fractionLength(0...1)))
    }
    
    private func queueBookSuggestionSearch(for title: String) {
        suggestionSearchTask?.cancel()
        
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmedTitle.count >= 2, trimmedTitle != selectedSuggestionTitle else {
            bookSuggestions = []
            bookSuggestionMessage = nil
            isSearchingBookSuggestions = false
            return
        }
        
        bookSuggestions = []
        bookSuggestionMessage = nil
        isSearchingBookSuggestions = true
        
        suggestionSearchTask = Task {
            try? await Task.sleep(for: .milliseconds(350))
            guard !Task.isCancelled else { return }
            await updateBookSuggestions(for: trimmedTitle)
        }
    }
    
    @MainActor
    private func updateBookSuggestions(for title: String) async {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmedTitle.count >= 2, trimmedTitle != selectedSuggestionTitle else {
            bookSuggestions = []
            return
        }

        do {
            bookSuggestions = try await GoogleBooksClient.searchBooks(matching: trimmedTitle)
            bookSuggestionMessage = bookSuggestions.isEmpty ? "No matching books found." : nil
        } catch {
            bookSuggestions = []
            bookSuggestionMessage = "Google Books is unavailable. Try again later."
        }
        
        isSearchingBookSuggestions = false
    }
    
    private func selectBookSuggestion(_ suggestion: GoogleBookSuggestion) {
        selectedSuggestionTitle = suggestion.title
        bookTitle = suggestion.title
        bookAuthor = suggestion.author
        coverImageURL = suggestion.thumbnailURL
        coverImageData = nil
        bookSuggestions = []
        bookSuggestionMessage = nil
        isSearchingBookSuggestions = false
        suggestionSearchTask?.cancel()
        suggestionSearchTask = nil
    }
    
    private func loadCoverImage(from item: PhotosPickerItem?) async {
        guard let item else { return }
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               UIImage(data: data) != nil {
                coverImageData = data
                coverImageURL = nil
            }
        } catch {
            coverImageData = nil
        }
    }
}

struct Book: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String
    var author: String
    var rating: Double
    var review: String = ""
    var imageName: String
    var imageFileName: String? = nil
    var coverImageURL: URL? = nil
}

enum BookImageManager {
    static func saveImage(_ data: Data) -> String? {
        let filename = UUID().uuidString + ".jpg"
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        do {
            try data.write(to: url)
            return filename
        } catch {
            print("Failed to save image: \(error)")
            return nil
        }
    }

    static func loadImage(named filename: String) -> Data? {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        return try? Data(contentsOf: url)
    }

    static func deleteImage(named filename: String) {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        try? FileManager.default.removeItem(at: url)
    }

    private static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

extension [Book]: @retroactive RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let decoded = try? JSONDecoder().decode([Book].self, from: data) else {
            return nil
        }
        self = decoded
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let string = String(data: data, encoding: .utf8) else {
            return "[]"
        }
        return string
    }
}

struct BookView: View {
    let book: Book
    var onEdit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack {
                HStack(spacing: 16) {
                    bookCover
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(book.title)
                            .font(.custom("Gaegu-Regular", size: 22))
                            .foregroundColor(Color.textColor)
                        
                        Text(book.author)
                            .font(.custom("Gaegu-Regular", size: 18))
                            .foregroundColor(Color.textColor)
                        
                        RatingView(rating: .constant(book.rating))
                    }
                    .frame(maxWidth: 200)
                    Spacer()
                }
                .frame(height: 120)
                
                if !book.review.isEmpty {
                    Divider()
                    Text(book.review)
                        .font(.custom("Gaegu-Regular", size: 16))
                        .foregroundColor(Color.textColor)
                        .lineLimit(3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12)
                .stroke(Color.textColor, lineWidth: 2))
            .padding(.horizontal)
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    onEdit()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 44, height: 44)
                        Image(systemName: "pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .tint(Color.background)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                }
            }
        }
    }
    
    private var bookCover: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue)
             
            if let filename = book.imageFileName,
               let data = BookImageManager.loadImage(named: filename),
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else if let coverImageURL = book.coverImageURL {
                AsyncImage(url: coverImageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    default:
                        Image(systemName: book.imageName)
                            .resizable()
                            .scaledToFit()
                            .padding(8)
                    }
                }
                .id(coverImageURL)
            } else {
                Image(systemName: book.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(8)
            }
        }
        .frame(width: 80, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct GoogleBookSuggestion: Identifiable, Equatable {
    let id: String
    let title: String
    let author: String
    let thumbnailURL: URL?
}

enum GoogleBooksClient {
    static func searchBooks(matching title: String) async throws -> [GoogleBookSuggestion] {
        var components = URLComponents(string: "https://www.googleapis.com/books/v1/volumes")
        components?.queryItems = [
            URLQueryItem(name: "q", value: title),
            URLQueryItem(name: "maxResults", value: "20"),
            URLQueryItem(name: "printType", value: "books"),
            URLQueryItem(name: "key", value: "AIzaSyCIAulWOKzQ8lGNMkrFWtNmYNbVi4vHovM")
        ]
        
        guard let url = components?.url else { return [] }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw GoogleBooksError.unavailable
        }
        
        let decodedResponse = try JSONDecoder().decode(GoogleBooksResponse.self, from: data)
        let searchedTitleKey = title.normalizedSuggestionKey
        var seenTitleAuthorPairs = Set<String>()
        var suggestions: [GoogleBookSuggestion] = []
        
        for item in decodedResponse.items ?? [] {
            guard let bookTitle = item.volumeInfo.title else { continue }
            let bookTitleKey = bookTitle.normalizedSuggestionKey
            
            guard bookTitleKey.hasPrefix(searchedTitleKey) || bookTitleKey.contains(searchedTitleKey) else { continue }
            
            let author = item.volumeInfo.authors?.joined(separator: ", ") ?? ""
            let titleAuthorKey = "\(bookTitleKey)|\(author.normalizedSuggestionKey)"
            
            guard !seenTitleAuthorPairs.contains(titleAuthorKey) else { continue }
            
            seenTitleAuthorPairs.insert(titleAuthorKey)
            suggestions.append(
                GoogleBookSuggestion(
                    id: item.id,
                    title: bookTitle,
                    author: author,
                    thumbnailURL: item.volumeInfo.imageLinks?.bestThumbnailURL
                )
            )
            
            if suggestions.count == 5 {
                break
            }
        }
        
        return suggestions
    }
}

enum GoogleBooksError: Error {
    case unavailable
}

private struct GoogleBooksResponse: Decodable {
    let items: [GoogleBooksItem]?
}

private extension String {
    var normalizedSuggestionKey: String {
        let foldedText = trimmingCharacters(in: .whitespacesAndNewlines)
            .folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
            .lowercased()
        
        return foldedText
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined()
    }
}

private struct GoogleBooksItem: Decodable {
    let id: String
    let volumeInfo: GoogleBooksVolumeInfo
}

private struct GoogleBooksVolumeInfo: Decodable {
    let title: String?
    let authors: [String]?
    let imageLinks: GoogleBooksImageLinks?
}

private struct GoogleBooksImageLinks: Decodable {
    let thumbnail: String?
    let smallThumbnail: String?
    
    var bestThumbnailURL: URL? {
        guard let urlString = thumbnail ?? smallThumbnail else { return nil }
        return URL(string: urlString.replacingOccurrences(of: "http://", with: "https://"))
    }
}

#Preview {
    Library()
}
