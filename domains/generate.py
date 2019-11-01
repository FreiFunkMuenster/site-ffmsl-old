#!/usr/bin/env python3
# -*- coding: utf8 -*-
import os
import hashlib
from jinja2 import Environment, FileSystemLoader

THIS_DIR = os.path.dirname(os.path.abspath(__file__))

domains = {
    99: { "names": { "insel": "Insel" }, "hide": True , "mesh_id": "02:d1:11:37:fc:00" },
    1: { "names": { "ffmsd01": "Münster-Mitte-Süd" }, "mesh_id": "02:d1:11:37:fc:39" },
    2: { "names": { "ffmsd02": "Münster-Ost" }, "mesh_id": "02:d1:11:37:fc:40" },
    3: { "names": { "ffmsd03": "Münster-Nord" }, "mesh_id": "02:d1:11:37:fc:41"  },
    4: { "names": { "ffmsd04": "Münster-West" }, "mesh_id": "02:d1:11:37:fc:42"  },
    5: { "names": { "ffmsd05": "Münster Süd" }, "mesh_id": "02:d1:11:37:fc:43"  },
    7: { "names": { "ffmsd07": "Telgte" }, "mesh_id": "02:d1:11:37:fc:45"  },
    8: { "names": { "ffmsd08": "Gescher" }, "mesh_id": "02:d1:11:37:fc:46"  },
    9: { "names": { "ffmsd09": "Stadtlohn" }, "mesh_id": "02:d1:11:37:fc:47"  },
    10: { "names": { "ffmsd10": "Borken-Nord" }, "mesh_id": "02:d1:11:37:fc:48"  },
    11: { "names": { "ffmsd11": "Bocholt" }, "mesh_id": "02:d1:11:37:fc:49"  },
    12: { "names": { "ffmsd12": "Dülmen" }, "mesh_id": "02:d1:11:37:fc:50"  },
    13: { "names": { "ffmsd13": "Rorup" }, "mesh_id": "02:d1:11:37:fc:51"  },
    14: { "names": { "ffmsd14": "Dingden" }, "mesh_id": "02:d1:11:37:fc:52"  },
    15: { "names": { "ffmsd15": "Heek" }, "mesh_id": "02:d1:11:37:fc:53"  },
    16: { "names": { "ffmsd16": "Münster Promenade" }, "mesh_id": "02:d1:11:37:fc:54"  },
    17: { "names": { "ffmsd17": "Emsdetten" }, "mesh_id": "02:d1:11:37:fc:55"  },
    18: { "names": { "ffmsd18": "Greven" }, "mesh_id": "02:d1:11:37:fc:56"  },
    19: { "names": { "ffmsd19": "Neuenkirchen" }, "mesh_id": "02:d1:11:37:fc:57"  },
    20: { "names": { "ffmsd20": "Ochtrup" }, "mesh_id": "02:d1:11:37:fc:58"  },
    21: { "names": { "ffmsd21": "Rheine" }, "mesh_id": "02:d1:11:37:fc:59"  },
    22: { "names": { "ffmsd22": "Steinfurt" }, "mesh_id": "02:d1:11:37:fc:60"  },
    23: { "names": { "ffmsd23": "Metelen" }, "mesh_id": "02:d1:11:37:fc:61"  },
    24: { "names": { "ffmsd24": "Wettringen" }, "mesh_id": "02:d1:11:37:fc:62"  },
    25: { "names": { "ffmsd25": "Kreis Steinfurt Ost" }, "mesh_id": "02:d1:11:37:fc:63"  },
    26: { "names": { "ffmsd26": "Borken-Zentrum" }, "mesh_id": "02:d1:11:37:fc:64"  },
    27: { "names": { "ffmsd27": "Selm" }, "mesh_id": "02:d1:11:37:fc:65"  },
    28: { "names": { "ffmsd28": "Horstmar" }, "mesh_id": "02:d1:11:37:fc:66"  },
    29: { "names": { "ffmsd29": "Laer" }, "mesh_id": "02:d1:11:37:fc:67"  },
    30: { "names": { "ffmsd30": "Nordwalde" }, "mesh_id": "02:d1:11:37:fc:68"  },
    31: { "names": { "ffmsd31": "Altenberge" }, "mesh_id": "02:d1:11:37:fc:69"  },
    32: { "names": { "ffmsd32": "Ahlen" }, "mesh_id": "02:d1:11:37:fc:70"  },
    33: { "names": { "ffmsd33": "Beckum" }, "mesh_id": "02:d1:11:37:fc:71"  },
    34: { "names": { "ffmsd34": "Beelen" }, "mesh_id": "02:d1:11:37:fc:72"  },
    35: { "names": { "ffmsd35": "Drensteinfurt" }, "mesh_id": "02:d1:11:37:fc:73"  },
    36: { "names": { "ffmsd36": "Ennigerloh" }, "mesh_id": "02:d1:11:37:fc:74"  },
    37: { "names": { "ffmsd37": "Everswinkel" }, "mesh_id": "02:d1:11:37:fc:75"  },
    38: { "names": { "ffmsd38": "Oelde" }, "mesh_id": "02:d1:11:37:fc:76"  },
    39: { "names": { "ffmsd39": "Ostbevern" }, "mesh_id": "02:d1:11:37:fc:77"  },
    40: { "names": { "ffmsd40": "Sassenberg" }, "mesh_id": "02:d1:11:37:fc:78"  },
    41: { "names": { "ffmsd41": "Sendenhorst" }, "mesh_id": "02:d1:11:37:fc:79"  },
    42: { "names": { "ffmsd42": "Wadersloh" }, "mesh_id": "02:d1:11:37:fc:80"  },
    43: { "names": { "ffmsd43": "Warendorf" }, "mesh_id": "02:d1:11:37:fc:81"  },
    44: { "names": { "ffmsd44": "Ascheberg" }, "mesh_id": "02:d1:11:37:fc:82"  },
    45: { "names": { "ffmsd45": "Billerbeck" }, "mesh_id": "02:d1:11:37:fc:83"  },
    46: { "names": { "ffmsd46": "Coesfeld" }, "mesh_id": "02:d1:11:37:fc:84"  },
    47: { "names": { "ffmsd47": "Havixbeck" }, "mesh_id": "02:d1:11:37:fc:85"  },
    48: { "names": { "ffmsd48": "Lüdinghausen" }, "mesh_id": "02:d1:11:37:fc:86"  },
    49: { "names": { "ffmsd49": "Nordkirchen" }, "mesh_id": "02:d1:11:37:fc:87"  },
    50: { "names": { "ffmsd50": "Nottuln" }, "mesh_id": "02:d1:11:37:fc:88"  },
    51: { "names": { "ffmsd51": "Olfen" }, "mesh_id": "02:d1:11:37:fc:89"  },
    52: { "names": { "ffmsd52": "Rosendahl" }, "mesh_id": "02:d1:11:37:fc:90"  },
    53: { "names": { "ffmsd53": "Senden" }, "mesh_id": "02:d1:11:37:fc:91"  },
    54: { "names": { "ffmsd54": "Ahaus" }, "mesh_id": "02:d1:11:37:fc:92"  },
    55: { "names": { "ffmsd55": "Heiden" }, "mesh_id": "02:d1:11:37:fc:93"  },
    56: { "names": { "ffmsd56": "Isselburg" }, "mesh_id": "02:d1:11:37:fc:94"  },
    57: { "names": { "ffmsd57": "Legden" }, "mesh_id": "02:d1:11:37:fc:95"  },
    58: { "names": { "ffmsd58": "Reken" }, "mesh_id": "02:d1:11:37:fc:96"  },
    59: { "names": { "ffmsd59": "Rhede" }, "mesh_id": "02:d1:11:37:fc:97"  },
    60: { "names": { "ffmsd60": "Schöppingen" }, "mesh_id": "02:d1:11:37:fc:98"  },
    61: { "names": { "ffmsd61": "Südlohn" }, "mesh_id": "02:d1:11:37:fc:99"  },
    62: { "names": { "ffmsd62": "Velen" }, "mesh_id": "02:d1:11:37:f1:00"  },
    63: { "names": { "ffmsd63": "Vreden" }, "mesh_id": "02:d1:11:37:f1:01"  },
    64: { "names": { "ffmsd64": "Borken-Süd" }, "mesh_id": "02:d1:11:37:f1:02"  },
    65: { "names": { "ffmsd65": "Ramschdomäne" }, "mesh_id": "02:d1:11:37:f1:03"  },
    66: { "names": { "ffmsd66": "Bottrop" }, "mesh_id": "02:d1:11:37:f1:04"  },
    67: { "names": { "ffmsd67": "Dorsten" }, "mesh_id": "02:d1:11:37:f1:05"  },
    68: { "names": { "ffmsd68": "Gelsenkirchen" }, "mesh_id": "02:d1:11:37:f1:06"  },
    69: { "names": { "ffmsd69": "Gladbeck" }, "mesh_id": "02:d1:11:37:f1:07"  },
    70: { "names": { "ffmsd70": "Haltern am See" }, "mesh_id": "02:d1:11:37:f1:08"  },
    71: { "names": { "ffmsd71": "Herten" }, "mesh_id": "02:d1:11:37:f1:09"  },
    72: { "names": { "ffmsd72": "Marl" }, "mesh_id": "02:d1:11:37:f1:10"  },
    73: { "names": { "ffmsd73": "Raesfeld" }, "mesh_id": "02:d1:11:f1:11"  },
    74: { "names": { "ffmsd74": "Recklinghausen" }, "mesh_id": "02:d1:11:37:f1:12"  },
    75: { "names": { "ffmsd75": "Gronau" }, "mesh_id": "02:d1:11:37:f1:13"  },
    76: { "names": { "ffmsd76": "Herne" }, "mesh_id": "02:d1:11:37:f1:14"  },
    77: { "names": { "ffmsd77": "Hamm" }, "mesh_id": "02:d1:11:37:f1:15"  },
}

def render(id, names, seed, hide, port, full_id, hex_id, mesh_id):
    j2_env = Environment(loader=FileSystemLoader(THIS_DIR),
                         trim_blocks=True)
    return j2_env.get_template('template.j2').render(
        id=id,
        names=names,
        seed=seed,
        hide=hide,
        str=str,
        port=port,
        full_id=full_id,
        hex_id=hex_id,
        mesh_id=mesh_id
    )

if __name__ == '__main__':

    for id, values in domains.items():
        names = values['names']
        mesh_id = values['mesh_id']

        seed = 'ff'+str(48143000000000000000000000000000000000000000000000000000000000+id)
        hide = values.get('hide', False)
        port = values.get('port', 20000 + id)
        full_id = str(id).zfill(2)
        primary_code = 'ffmsd' + full_id
        hex_id = hex(id).split('x')[-1]
        with open(THIS_DIR + '/' + primary_code + '.conf', 'w') as f:
            f.write(render(id, names, seed, hide, port, full_id, hex_id, mesh_id))
