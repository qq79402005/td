import os
import shutil
import json

root_path = os.getcwd() + '/'
java_save_path = root_path + "../server/src/protocol/"
gd_save_path   = root_path + "../client/global/protocol/"

# recreate java file save path
if os.path.exists(java_save_path):
    shutil.rmtree(java_save_path)

os.mkdir(java_save_path)

if os.path.exists(gd_save_path):
    shutil.rmtree(gd_save_path)

os.mkdir(gd_save_path)

def gen_protocol_java( file):
    protocol_name = os.path.splitext(file)[0]

    java_file = open(java_save_path + protocol_name + ".pb.java", "w+")
    java_file.writelines("package proto\n\n")
    java_file.writelines("public class " + protocol_name + " {\n")
    java_file.writelines("}\n")
    java_file.close()

def gen_protocol_godot(file):
    protocol_name = os.path.splitext(file)[0]

    gd_file_name = gd_save_path + protocol_name + ".pb.gd"
    gd_file = open( gd_file_name, "w+")
    gd_file.writelines("extends Node\n\n")

    with open(file) as data_file:
        data = json.load(data_file) 
        for key in data.keys():
            gd_file.writelines("var " + key + " = " + data[key] +"(0)\n")

    gd_file.writelines("\n")
    gd_file.writelines("func _ready():\n")
    gd_file.writelines("\tpass\n")
    gd_file.close()

    print("generate " + gd_file_name + " succeed")

dirs = os.listdir(root_path)
for file in dirs:
    if os.path.splitext(file)[1] == '.proto':
        gen_protocol_java( file)
        gen_protocol_godot(file)
