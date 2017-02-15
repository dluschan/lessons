import os
import random
import shutil

experiment_dir = "experiment/"
updir = "../"
src_file = "containers.pas"
variant_count = 30
container_order = [[0, 1], [1, 0]]
containers_dir = ["vector/", "list/"]
containers_alias = [[["vector/", "container1/"], ["list/", "container2/"]], [["vector/", "container2/"], ["list/", "container1/"]]]

obfuscate_src = """
    var
	    a: array[1..8769] of integer;
    	x: integer;
    	s: longInt;
    begin
        s := -400;
    	for x := 8764 downto 12 do
        begin
    		a[x] := 2 * x - 8;
            s := a[x] + s * 2 - 159;
        end;
        a[4] := s + a[5];
    end;

"""

def get_proc_body():
    return obfuscate_src

def get_rnd_fun_name():
    return "rnd_fun_" + str(random.getrandbits(100))

def get_proc_signature():
    return "procedure " + get_rnd_fun_name() + "();"

def get_rnd_proc():
    return get_proc_signature() + get_proc_body()

def alinement(src_file):
    f = open(src_file)
    lines = f.readlines()
    f.close
    f = open(src_file, 'w')
    for line in lines:
        f.write(line)
        if line.find("implementation") != -1:
            for i in range(4):
                f.write(get_rnd_proc())
    f.close()

def obfuscate(src_file):
    f = open(src_file)
    lines = f.readlines()
    f.close
    f = open(src_file, 'w')
    for line in lines:
        f.write(line)
        if line.find("implementation") != -1:
            for i in range(random.randint(5, 20)):
                f.write(get_rnd_proc())
    f.close()

if os.path.exists(experiment_dir) == True:
    print("Error! Temporary directory already exists!")
    ans = input("Remove it?: ")
    if ans.lower() in ['yes', 'y', 'ok']:
        shutil.rmtree(experiment_dir)
    else:
        exit(100)

file_key = open("key.txt", 'w')
os.mkdir(experiment_dir)
os.chdir(experiment_dir)
for i in range(variant_count):
    var = str(i).rjust(2, '0')
    file_key.write("variant " + var + "\n")
    os.mkdir(var)
    os.chdir(var)
    alias = random.choice(containers_alias)
    for container in alias:
        file_key.write(container[1] + " " + container[0] + "\n")
        os.mkdir(container[1])
        os.chdir(container[1])
        shutil.copyfile(updir + updir + updir + container[0] + src_file, src_file)
        if container[0] == "vector/":
            alinement(src_file)
        obfuscate(src_file)
        os.system("fpc " + src_file)
        os.remove(src_file)
        os.chdir(updir)
    os.chdir(updir)
os.chdir(updir)
file_key.close
