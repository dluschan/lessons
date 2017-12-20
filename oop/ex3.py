class Book:
    def __init__(self, author):
        self.setAuthor(author)

    def setAuthor(self, name):
        self.author = name

aBook = Book("Достоевский")

print(aBook.author)
