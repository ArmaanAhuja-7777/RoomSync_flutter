efficiency = 3
usable_coins = tuple()
total_coins = 0
for day in range(1, n+1): 
    for gift in gifts: 
        if day == gift[0]: 
            usable_coins.append(gift[1])

#yahan sort kro tuple ko kisi trh descending order mei ye jo diya hai shyd yehi hai
sorted_usable_coins = sorted(usable_coins, reverse=True)
        
for i in range(1, 4): 
    if efficiency == 0: 
        break
    else: 
     total_coins = total_coins+ efficiency*usable_coins[i-1]
     efficiency = efficiency-1

