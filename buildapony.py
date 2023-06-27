#!/usr/bin/env python3
import os
import re
import shutil
import sys
import tomllib
from argparse import ArgumentParser

parser = ArgumentParser(
        description='Builds Figura-Ponies models for either development\
     or release.',
        epilog='Be sure to read the documentation! -#!')
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
                    help="Disables the pre-existing build check, automatically\
     overwriting old builds.")
parser.add_argument('model',
                    choices=os.listdir("./models") + ["all", "clean"],
                    help="Will determine the model type of the export, 'all'\
     will batch build every possible model,\
     'clean' will clean out the build directory.")
args = parser.parse_args()


def pony_builder(model, size):
    # Checks for build path, creates it if not found
    if not os.path.exists("./build"):
        os.mkdir("./build")
    # Define buildpath for keeping code clean
    buildpath = f"./build/{model}-{size}"
    if os.path.exists(buildpath):
        if args.force is True:
            shutil.rmtree(buildpath)
        else:
            exitprompt = input(f"A pre-existing build exists here!\
                 Overwrite {buildpath}? (y/n)\n> ").lower()
            if exitprompt == ("y"):
                print("Deleting old build and rebuilding...")
                shutil.rmtree(buildpath)
            else:
                return
    # Pre-check if the size exists, exits with an error code if not
    if not os.path.isfile(f"./models/{model}/{size}.bbmodel"):
        print("ERROR: This Size of model does not exist.")
        sys.exit(1)
    # Copy lua scripts and avatar.json from ./src to build destination
    shutil.copytree("./src", buildpath)
    # Copy textures from model to build destination
    shutil.copytree(f"./models/{model}/textures", f"{buildpath}/Textures")
    # Copy BlockBench model for model and size to build destination as pony.bbmodel
    shutil.copy(f"./models/{model}/{size}.bbmodel", f"{buildpath}/pony.bbmodel")
    # Open avatar.json, read it's contents, replace MODEL and SIZE placeholders with relevant data, and write it
    with open(f"{buildpath}/avatar.json", "r") as file:
        avatarjson = file.read()
    avatarjson = avatarjson.replace('$MODEL', model.capitalize()).replace('$SIZE', size.capitalize())
    with open(f"{buildpath}/avatar.json", "w") as file:
        file.write(avatarjson)
    # Open InitValues.lua, replace Horn, Magic, and Wings values with corresponding values in config.toml
    # Will fall back to the "generic" values in config.toml if there's no corresponding data
    with open(f"{buildpath}/initValues.lua", "r") as file:
        initvalues = file.read()
    with open("./config.toml", "rb") as file:
        data = tomllib.load(file)
    initvalues = initvalues\
    .replace("Horn = true", f"Horn = {str(data[model]['Horn']).lower()}")\
    .replace("Magic = true", f"Magic = {str(data[model]['Magic']).lower()}")\
    .replace("Wings = true", f"Wings = {str(data[model]['Wings']).lower()}")
    with open(f"{buildpath}/initValues.lua", "w") as file:
        file.write(initvalues)
    if args.zip is True:
        if not os.path.exists("./build/release"):
            os.mkdir("./build/release")
        if os.path.exists(f"./build/release/{model}-{size}.zip"):
            os.remove(f"./build/release/{model}-{size}.zip")
        shutil.make_archive(f"./build/release/{model}-{size}", "zip", root_dir=f"./build/{model}-{size}", base_dir="./")


if __name__ == "__main__":
    # Cleans out the build directory. squeaky clean!
    if args.model == "clean":
        print("Cleaning build directory.")
        try:
            shutil.rmtree("./build")
            sys.exit(0)
        except FileNotFoundError:
            print("No build directory found.")
            sys.exit(1)
    # Runs a batch build of every model in ./models
    elif args.model == "all":
        for m in os.listdir("./models/"):
            if args.size is None:
                possiblesizes = []
                for i in os.listdir(f"./models/{m}"):
                    if i.endswith(".bbmodel"):
                        possiblesizes.append(re.sub(".bbmodel$","",i))
                for s in possiblesizes:
                    pony_builder(m, s)
            else:
                pony_builder(m, args.size)
    # Builds every size of a specific model if size is not specified.
    elif args.size is None:
        possiblesizes = []
        for i in os.listdir(f"./models/{args.model}"):
            if i.endswith(".bbmodel"):
                possiblesizes.append(re.sub(".bbmodel$","",i))
        for i in possiblesizes:
            pony_builder(args.model, i)
    # When the stars align, it builds with the specified model and size.
    else:
        pony_builder(args.model, args.size)
