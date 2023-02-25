#!/usr/bin/env python3
import os
import sys
import fileinput
import shutil
import tomllib
from argparse import ArgumentParser

#cwd = os.getcwd()
parser = ArgumentParser(
        description = 'Builds Figura-Ponies models for either development or release.', 
        epilog = 'Be sure to read the documentation! -#!')
parser.add_argument('-s', 
                    '--size', 
                    choices=['large', 'medium', 'tall'], 
                    help="Will determine the body type of the export.")
parser.add_argument('-z', 
                    '--zip', 
                    action='store_true',
                    help="Zips the model for release.")
parser.add_argument('-f', 
                    '--force', 
                    action='store_true',
                    help="Disables the pre-existing build check, automatically overwriting old builds.")
parser.add_argument('model', 
                    choices=os.listdir("./models"), 
                    help="Will determine the model type of the export.")
args = parser.parse_args()
#print(args)

def pony_builder():
    # Checks for build path, creates it if not found
    if not os.path.exists("./build"):
        os.mkdir("./build")
    # Define buildpath for keeping code clean
    buildpath = f"./build/{args.model}-{args.size}"
    if os.path.exists(buildpath):
        if args.force == True:
            shutil.rmtree(buildpath)
        else:
            exitprompt = input("A pre-existing build exists here! Overwrite it? (y/n)\n> ").lower()
            if exitprompt == ("y"):
                print("Deleting old build and rebuilding...")
                shutil.rmtree(buildpath)
            else:
                print("Exiting.")
                sys.exit(0)
    # Pre-check if the size exists, exits with an error code if not
    if not os.path.isfile(f"./models/{args.model}/{args.size}.bbmodel"):
        print("ERROR: This Size of model does not exist.")
        sys.exit(1)
    # Copy lua scripts and avatar.json from ./src to build destination
    shutil.copytree("./src", buildpath)
    # Copy textures from model to build destination
    shutil.copytree(f"./models/{args.model}/textures", f"{buildpath}/textures")
    # Copy BlockBench model for model and size to build destination as pony.bbmodel
    shutil.copy(f"./models/{args.model}/{args.size}.bbmodel", f"{buildpath}/pony.bbmodel")
    # Open avatar.json, read it's contents, replace MODEL and SIZE placeholders with relevant data, and write it
    with open(f"{buildpath}/avatar.json", "r") as file:
        avatarjson = file.read()
    avatarjson = avatarjson.replace('MODEL', args.model.capitalize()).replace('SIZE', args.size.capitalize())
    with open(f"{buildpath}/avatar.json", "w") as file:
        file.write(avatarjson)
    # Open InitValues.lua, replace Horn, Magic, and Wings values with corresponding values in config.toml
    # Will fall back to the "generic" values in config.toml if there's no corresponding data
    with open(f"{buildpath}/InitValues.lua", "r") as file:
        initvalues = file.read()
    with open("./config.toml", "rb") as file:
        data = tomllib.load(file)
    initvalues = initvalues.replace("Horn = true", f"Horn = {str(data[args.model]['Horn']).lower()}")\
    .replace("Magic = true", f"Magic = {str(data[args.model]['Magic']).lower()}")\
    .replace("Wings = true", f"Wings = {str(data[args.model]['Wings']).lower()}")
    with open(f"{buildpath}/InitValues.lua", "w") as file:
        file.write(initvalues)





if __name__ == "__main__":
    pony_builder()
