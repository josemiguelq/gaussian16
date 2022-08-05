import mmap
from decimal import Decimal


with open('triazol-Cu-opt.log', 'r') as f:
    atoms = {"29": "Cu", "8" : "O", "7" : "N", "6":"C", "1": "H", "17" : "Cl"}
    m = mmap.mmap(f.fileno(), 0, prot=mmap.PROT_READ)  
    
    i = m.rfind(b'Number     Number       Type             X           Y           Z')
    m.seek(i)
    line = m.readline()
    nextline = m.readline()
    f = open("coordinates_input.xyz", "a")
    f.write("%Nproc=6\n")
    f.write("%Mem=4GB\n")
    f.write("# B3LYP/GEN freq pop=full gfinput gfprint PSEUDO=READ\n")
    f.write("frequencies triazol Cu\n")
    f.write("\n")
    f.write("0 	2 \n")
    	
    for c in range(91):
        coord = m.readline()
        columns =  coord.split()[1:6]
        del columns[1]
        line = ""
        for idx in range(len(columns)):
            if idx == 0:
                line+= atoms.get(columns[0].decode('utf-8'))
            else:
                line+="         {:18.14f}".format(Decimal(columns[idx].decode('utf-8')))
        f.write(line+"\n")
    f.close()    
