digits = [0 for i in range(10)]
for c in input():
    digits[int(c)] += 1

sum = 0
for i in range(10):
    sum += i * digits[i]

if sum % 3 != 0:
    for i in range(10):
        if digits[i] > 0 and (sum - i) % 3 == 0:
            digits[i] -= 1
            sum -= i
            break

for step in range(2):
    if sum % 3 != 0:
        for i in range(10):
            if digits[i] > 0 and i % 3 != 0:
                digits[i] -= 1
                sum -= i
                break

for i in range(9, -1, -1):
    print(str(i) * digits[i], end='')
print()
