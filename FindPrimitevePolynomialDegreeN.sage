import random 

R.<x> = GF(2)[]
n = 64
N = 2^n - 1  #2^64 - 1

print(f"Αναζήτηση πρωταρχικού πολυωνύμου βαθμού {n}...")

prime_factors = N.prime_factors()#each number is a factor of prime numbers

found = False
counter = 0
while not found:
    counter = counter + 1

    #f = R.random_element(degree=n, monic=True) #gives a polynomial with degree n
    #if f.constant_coefficient() == 0: #assures the last coefficient is one
        #continue
    coefficients = [1]
    for i in range (n-1):
        coef = random.randint(0, 1)
        coefficients = coefficients + [coef]
        
    coefficients = coefficients + [1] #Assures the degree n 
    f = sum(coefficients[i] * x^i for i in range(len(coefficients)))
    
    if not f.is_irreducible():#checks if the polynomial is irreducible
        continue

    if f.is_squarefree():
        if pow(x, N, f) == 1:
            is_primitive = True
            for p in prime_factors:
                if pow(x, N // p, f) == 1:
                    is_primitive = False
                    break
    
            if is_primitive:
                found = True


# Verify with built-in function
if f.is_primitive():
    print(f"Found primitive polynomial {f} after {counter} tries")
else:
    print("Failed to find primitive polynomial")