from apps.salt_dev.models import MinionList


def batch_create(start_id, login_num, add_num):
    free_num = 0
    proj = 'dm'
    minion_list = {}

    total_zoneid_list = [str(i).zfill(2) for i in range(1, 6 + 1)]
    minionList = MinionList.objects.all()
    for v in minionList:
        m = v.zonelist_set.filter(m_zone=0)
        print("m:", m)
        use_id_list = []
        # free_id_list = []
        for b in m:
            use_id_list.append(b.id)
        free_id_list = list(set(total_zoneid_list).difference(set(use_id_list)))
        minion_list[v.minion_id] = {'ip': v.ip, 'domain': v.do_main, 'db': '127.0.0.1', 'zone_id': free_id_list}
        free_num += len(free_id_list)
    # 可使用的minion数量
    use_server_num = len(minion_list)
    print("free_num:", free_num)
    init_add = int(add_num)
    if add_num <= free_num:
        add_datas = {"add_yml_datas": {}, "add_json_datas": [], "add_sql_datas": []}
        used_list = []
        stop_sign = 0
        init_start = start_id
        end_id = start_id + add_num

        while start_id < end_id:
            for k, v in minion_list.items():
                if start_id < end_id:
                    if len(v["zone_id"]) == 0:
                        if k not in used_list:
                            used_list.append(k)
                            use_server_num -= 1
                        continue
                    if use_server_num == 1:
                        if add_datas["add_yml_datas"]:
                            if k == add_datas["add_yml_datas"][int(start_id - 1)]['host']:
                                stop_sign = 1
                                break
                    add_datas["add_yml_datas"][start_id] = {"name": "server" + str(start_id), "host": k, "ip": v['ip'],
                                                            'db': v['db'], 'id': v['zone_id'][0]}

                    json = {"zone_id": start_id, "name": "server" + str(start_id), "ip": v['ip'], 'db': v['db'],
                            'id': v['zone_id'][0], "minion_id": k}
                    add_datas["add_sql_datas"].append(json)

                    urls_game_list = []
                    urls_login_port = 10000 + int(v['zone_id'][0]) * 10
                    urls_game_port = 9000 + int(v['zone_id'][0]) * 10

                    for i in range(0, login_num):
                        urls_game_list.append(str(v['domain']) + ":" + str(urls_game_port))
                        urls_game_port += 1

                    if proj == "dm":
                        add_datas["add_json_datas"].append(
                            {"id": start_id, "name": "Server-" + str(start_id), "state": 5,
                             "urls_login": [str(v['domain']) + ":" + str(urls_login_port)], "urls_game": urls_game_list})
                    elif proj == "pm":
                        add_datas["add_json_datas"].append(
                            {"id": start_id, "name": "Server-" + str(start_id), "state": 5, "urls": urls_game_list})
                    del v['zone_id'][0]
                    start_id += 1

            if stop_sign == 1:
                add_datas['Warning'] = 'Warning: 需创建区服数: %d, 已创建区服: %d, 已创建最后一个区服id: %d' % (
                    init_add, start_id - int(init_start), start_id - 1)
                print(add_datas['Warning'])
                break
        return add_datas
