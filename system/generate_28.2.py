from random import randint, choice

d = """один
два
три
четыре
пять
шесть
семь
восемь
девять
одиннадцать
двенадцать
тринадцать
четырнадцать
пятнадцать
шестнадцать
семнадцать
восемнадцать
девятнадцать
десять
двадцать
тридцать
сорок
пятьдесят
шестдесят
семдесят
восемдесят
девяноста"""

r = """сто один
двадцать два
миллион три
четыре тысячи
пять фффф
шесть целых пять десятых
восьмьдесят семь
тридцать восемь
девяноста девять
четыреста одиннадцать
три миллиона двести двенадцать
тринадцать
двести четырнадцать
пять тысяч пятнадцать
шестнадцать тысяч ровно
семнадцать с половиной
восемнадцать триллионов сто миллионов пятнадцать тысяч девять
девятнадцать
восемьсот десять
двадцать один
тридцать два
сорок четыре
пять тысяч пятьдесят пять
два миллиона шестдесят
семьдесят восемь
восемьдесят два
девяноста один
двадцать восемь
два миллиона
четырнадцать
сто двадцать три
тысяча девятьсот восемьдесят четыре
сорок разбойников
девятоста два
сто пятнадцать
тысяча восемьдесят
сорок пять
одиннадцать
тридцать три
тридцать пять
пятьдесят восемь
шестьдесят шесть
пятьдесят пять
тринадцать
восемь
два
один
ноль
минус один
двадцать"""

print(d)
n = randint(5, 50)
print(n)

numbers = r.split('\n')
for i in range(n):
    print(choice(numbers))
