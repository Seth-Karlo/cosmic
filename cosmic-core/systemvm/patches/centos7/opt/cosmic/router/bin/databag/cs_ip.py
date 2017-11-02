def merge(dbag, ip):
    if ip['add']:
        dbag['interfaces'][ip['mac_address']]['ipv4_addresses'][ip['cidr']] = {}
    else:
        dbag['interfaces'][ip['mac_address']]['ipv4_addresses'].pop(ip['cidr'], None)

    return dbag
