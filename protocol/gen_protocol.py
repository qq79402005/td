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

def gen_protocol_java( file, id):
    protocol_name = os.path.splitext(file)[0]

    java_file_name = java_save_path + protocol_name + ".java"
    java_file = open(java_file_name, "w+")
    java_file.writelines("package protocol;\n\n")
    java_file.writelines("import java.nio.ByteBuffer;\n\n")
    java_file.writelines("public class " + protocol_name + " {\n\n")

    data_file = open(file)
    data = json.load(data_file) 
    for key in data.keys():
        java_file.writelines("\tpublic " + data[key] +" " + key + " = 0;\n")

    # get_id
    java_file.writelines("\n")
    java_file.writelines("\tpublic int id(){\n")
    java_file.writelines("\t\t return %d;\n" % id)
    java_file.writelines("\t}\n")

    # get_size
    length = 0
    for key in data.keys():
        if data[key]=='int':
            length += 4

    java_file.writelines("\n")
    java_file.writelines("\tpublic int length(){\n")
    java_file.writelines("\t\t return %d;\n" % length)
    java_file.writelines("\t}\n")

    # data
    java_file.writelines("\n")
    java_file.writelines("\tpublic byte[] data(){\n")
    java_file.writelines("\t\tByteBuffer byteBuffer = ByteBuffer.allocate(8+length());\n")
    java_file.writelines("\t\tbyteBuffer.putInt(id());\n")
    java_file.writelines("\t\tbyteBuffer.putInt(length());\n")
    for key in data.keys():
        java_file.writelines("\t\tbyteBuffer.putInt(%s);\n" % key)

    java_file.writelines("\t\treturn byteBuffer.array();\n")
    java_file.writelines("\t}\n")

    # parse_data
    java_file.writelines("\n")
    java_file.writelines("\tpublic boolean parse_data(byte[] byteArray){\n")
    java_file.writelines("\t\tByteBuffer byteBuffer = ByteBuffer.wrap(byteArray);\n")
    java_file.writelines("\t\tint msg_id = byteBuffer.getInt();\n")
    java_file.writelines("\t\tint msg_length = byteBuffer.getInt();\n")
    java_file.writelines("\t\tif(msg_id==id() && msg_length==length()){\n")
    for key in data.keys():
        java_file.writelines("\t\t\t%s = byteBuffer.getInt();\n" % key)
    
    java_file.writelines("\t\t\treturn true;\n")
    java_file.writelines("\t\t}\n")
    java_file.writelines("\t\telse {\n")
    java_file.writelines("\t\t\treturn false;\n")
    java_file.writelines("\t\t}\n")
    java_file.writelines("\t}\n")
    # end
    java_file.writelines("}\n")
    java_file.close()

    print("generate " + java_file_name + " succeed")
    data_file.close()


def gen_protocol_godot(file, id):
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
    gd_file.writelines("\tpass\n\n")
    gd_file.writelines("func get_id():\n")
    gd_file.writelines("\treturn %d\n" % id)
    gd_file.close()

    print("generate " + gd_file_name + " succeed")

dirs = os.listdir(root_path)
id = 1
for file in dirs:
    if os.path.splitext(file)[1] == '.proto':
        gen_protocol_java( file, id)
        gen_protocol_godot(file, id)
        id+=1
