#!/usr/bin/python
# -- coding: utf-8 --


import logging
from optparse import OptionParser

from cs.CsConfig import CsConfig
from cs.CsDatabag import CsCmdLine
from cs.CsRedundant import CsRedundant

parser = OptionParser()
parser.add_option("-m", "--master",
                  action="store_true", default=False, dest="master",
                  help="Set router master")
parser.add_option("-b", "--backup",
                  action="store_true", default=False, dest="backup",
                  help="Set router backup")
parser.add_option("-f", "--fault",
                  action="store_true", default=False, dest="fault",
                  help="Notify Fault")
(options, args) = parser.parse_args()

config = CsConfig()
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s  %(filename)s %(funcName)s:%(lineno)d %(message)s')

config.cmdline()
cl = CsCmdLine("cmdline", config)
# Update the configuration to set state as backup and let keepalived decide who the real Master is!
cl.set_master_state(False)
cl.save()

config.set_address()
red = CsRedundant(config)

if options.master:
    red.set_master()

if options.backup:
    red.set_backup()

if options.fault:
    red.set_fault()
