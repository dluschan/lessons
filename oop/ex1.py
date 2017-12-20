class Book:
    def __init__(self, author = "Unknown"):
        self.setAuthor(author)
        
    def setAuthor(self, author):
        self.author = author
        
aBook = Book("John")
bBook = Book()
aBook.setAuthor("")
bBook.setAuthor("Georgy")
print(aBook.author)
