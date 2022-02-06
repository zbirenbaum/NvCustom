# def ftolist(filename):
    # newlist = []
    # with open(filename, "r") as f:
    #     line = f.readline()
    #     newlist.append(line)
    #     while(line):
    #         line=f.readline()
    #         newlist.append(f.readline())
    
old = [line.strip("\n\t\r,") for line in open('./highlight_old')]
new = [line.strip("\n\t\r,") for line in open('./highlight_new')]

old = sorted(old)
new = sorted(new)
print(old)
print(new)

# difflist = []
# for n,o in zip(new, old):
#     if n != o:
#         difflist.append((n,o))
#         print("new: " + n + "  |   old: " + o)
#
# print(len(difflist))
