#!/usr/bin/env python3
import yaml
import sys
import os

IN_PATH = "./recipes/"
OUT_PATH = "./xml/"
IN_EXTENSION = ".yml"
OUT_EXTENSION = ".xml"

TEMPLATE = """
<serviceResponse>
<recipe xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<title>{}</title>
<description>{}</description>
<ingredients>
{}
</ingredients>
<methods>
{}
</methods>
</recipe>
<response>
<status>SUCCESS</status>
</response>
</serviceResponse>
"""

def generate_ingredient(item):
    return "<ingredient><quantity>1</quantity><name>{0}</name><displayText>{0}</displayText></ingredient>".format(item)

def generate_step(item):
    return "<method><description>{0}</description></method>".format(item)


out_file = os.path.join(OUT_PATH, "index.xml")
with open(out_file, "w+") as hahayes: 
    hahayes.write("<serviceResponse><recipes>\n")
    in_files = [f for f in os.listdir(IN_PATH) if os.path.isfile(os.path.join(IN_PATH, f)) and f.endswith(IN_EXTENSION)]
    for in_file in in_files:
        with open(os.path.join(IN_PATH, in_file), "r") as f:
            docs = yaml.load_all(f)
            recipe = [d for d in docs][0] #ignore additional recipes
        out_file = os.path.join(OUT_PATH, os.path.splitext(in_file)[0] + OUT_EXTENSION)
        with open(out_file, "w+") as f: 
            ingredients = "\n".join([generate_ingredient(x) for x in recipe["ingredients"]])
            steps = "\n".join([generate_step(x) for x in recipe["steps"]])
            hahayes.write("<recipe><title>{}</title><description>{}</description><url>{}</url></recipe>\n".format(recipe["title"], recipe["description"], out_file))
            f.write(TEMPLATE.format(recipe["title"], recipe["description"], ingredients, steps))
    hahayes.write("</recipes></serviceResponse>\n")
