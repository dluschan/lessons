def calculate_route(num, minus, plus, skip):
    route = ''
    while num != 0:
        c = num % 3
        num //= 3
        if c == 2:
            route += minus
            num += 1
        elif c == 1:
            route += plus
        else:
            route += skip
    return route

x1, y1, x2, y2 = map(int, input().split())
route_x = calculate_route(x2 - x1, 'l', 'r', 's')
route_y = calculate_route(y2 - y1, 'd', 'u', 's')

route_x = route_x.ljust(len(route_y), 's')
route_y = route_y.ljust(len(route_x), 's')
res = ''
for i in range(len(route_y)):
    if 's' in [route_x[i], route_y[i]]:
        res += (route_x[i] if route_x[i] != 's' else route_y[i])
    else:
        print('no')
        exit(0)

print('yes')
print(res)
