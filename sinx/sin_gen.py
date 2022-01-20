import math
for x in range(0,2**8) :
    tpx = 2.0 * 3.1415926535 * float(x) / float(2**10)
    y = 2**7 * math.sin(tpx)
    print("\t\t8'h{0:02X}: data = 7'b{1:07b};".format(x,int(y)))
