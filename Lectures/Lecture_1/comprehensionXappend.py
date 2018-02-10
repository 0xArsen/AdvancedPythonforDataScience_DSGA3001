def list_by_append():
    l1 = []
    for i in range(100000):
        l1.append(i)

def list_by_comprehension():
    l1 = [i for i in range(100000)]

if __name__=="__main__":
    list_by_append()
    list_by_comprehension()
