import json
import yaml
import time


def sql_to_yaml(data):
    test = []
    for obj in data:
        test.append({list(obj.values())[0]: {list(obj.keys())[1]: list(obj.values())[1],
                                             list(obj.keys())[2]: list(obj.values())[2],
                                             list(obj.keys())[3]: list(obj.values())[3],
                                             list(obj.keys())[4]: list(obj.values())[4],
                                             list(obj.keys())[5]: list(obj.values())[5]}})

    return yaml.dump(test, default_flow_style=False, encoding='utf-8', allow_unicode=True)


def get_data(filename):
    with open(filename, "r", encoding='utf-8') as f:
        data = yaml.safe_load(f.read())
    return data


def check_yaml(zones_list):
    data = get_data("/data/salt/pillar/game.sls")
    for i in zones_list:
        if i in data['game']['zones'].keys():
            return "", True
        # elif 'zones_wait' not in data['game'].keys():
        #     return "%s 区暂未创区" % i, False
        elif i in data['game']['zones_wait'].keys():
            return "%s 区还未开服" % i, False
        else:
            return "区服不存在", False

def update_yaml(t, zone_id, v):
    data = get_data("/data/salt/pillar/game.sls")
    new_data = {int(zone_id): v}
    backup_file("yaml", "game.sls")
    if 'zones' not in data['game'].keys():
        data['game'].update({'zones': new_data})
    else:
        if t == 'create' or t == 'update':
            data['game']['zones'].update(new_data)
        else:
            data['game']['zones'].pop(int(zone_id))
    with open("/data/salt/pillar/game.sls", "w", encoding='utf-8') as f:
        yaml.dump(data, f, allow_unicode=True, sort_keys=False)


def delete_yaml(zones):
    data = get_data("/data/salt/pillar/game.sls")
    backup_file("yaml", "game.sls")
    
    for i in zones:
        data['game']['zones'].pop(int(i))
    with open("/data/salt/pillar/game.sls", "w", encoding='utf-8') as f:
        yaml.dump(data, f, allow_unicode=True, sort_keys=False)


def move_yaml(zone_id):
    data = get_data("/data/salt/pillar/game.sls")
    backup_file("yaml", "game.sls")
    new_data = {zone_id: data['game']['zones'].pop(int(zone_id))}
    if 'zones_wait' not in data['game'].keys():
        data['game'].update({"zones_wait": new_data})
    # elif data['game']['zones_wait'] == {}:
    #     data['game']['zones_wait'].update(new_data)
    else:
        data['game']['zones_wait'].update(new_data)
    with open("/data/salt/pillar/game.sls", "w", encoding='utf-8') as f:
        yaml.dump(data, f, allow_unicode=True, sort_keys=False)
    

def batch_create_yaml(t, new_data):
    data = get_data("/data/salt/pillar/game.sls")
    backup_file("yaml", "game.sls")
    if t == 'initial_create':
        data['game'].update({'zones': new_data})
    else:
        data['game']['zones'].update(new_data)
    with open("/data/salt/pillar/game.sls", "w", encoding='utf-8') as f:
        yaml.dump(data, f, allow_unicode=True, sort_keys=False)


def backup_file(t, filename):
    if t == "yaml":
        url = "/data/salt/pillar/"
    else:
        url = "/data/ProjectDM/group/"
    new_file = url + filename + "." + time.strftime("%Y%m%d%H%M")

    with open(url+filename, "r") as old_data:
        with open(new_file, "w") as new_data:
            new_data.write(old_data.read())


def extend_json(t, new_data):
    proj = 'dm'
    login_num = 4
    data = get_data("/data/ProjectDM/group/server_list.json")
    backup_file("json", "server_list.json")

    urls_game_list = []
    print(new_data)
    urls_login_port = 10000 + int(new_data.get('id')) * 10
    urls_game_port = 9000 + int(new_data.get('id')) * 10
    json_data = []

    for i in range(0, login_num):
        urls_game_list.append(str(new_data.get('domain')) + ":" + str(urls_game_port))
        urls_game_port += 1

    if proj == 'dm':
        json_data.append({"id": int(new_data.get('zone_id')), "name": "Server-" + str(new_data.get('zone_id')), "state": 5,
                          "urls_login": [str(new_data.get('domain')) + ":" + str(urls_login_port)],
                          "urls_game": urls_game_list})
        if t == 'update':
            data['servers'][int(new_data.get('zone_id'))-1] = json_data
        else:
            data['servers'].extend(json_data)
    else:
        json_data.append({"id": int(new_data.get('zone_id')), "name": "Server-" + str(new_data.get('zone_id')), "state": 5,
                          "urls": urls_game_list})
        if t == 'update':
            data['games'][int(new_data.get('zone_id'))-1] = json_data
        else:
            data['games'].extend(json_data)
    with open("/data/ProjectDM/group/server_list.json", 'w+') as f:
        json.dump(data, f, indent=4, separators=(',', ': '), ensure_ascii=False)


def batch_extend_json(new_data):
    proj = 'dm'
    data = get_data("/data/ProjectDM/group/server_list.json")
    backup_file("json", "server_list.json")
    if proj == "dm":
        data['servers'].extend(new_data)
    elif proj == "pm":
        data['games'].extend(new_data)
        
    with open("/data/ProjectDM/group/server_list.json", 'w+') as f:
        json.dump(data, f, indent=4, separators=(',', ': '), ensure_ascii=False)


def delete_json(zone_id):
    proj = 'dm'
    data = get_data("/data/ProjectDM/group/server_list.json")
    backup_file("json", "server_list.json")
    if proj == 'dm':
        for i in data['servers']:
            if i['id'] == int(zone_id):
                data['servers'].remove(i)
    else:
        for i in data['games']:
            if i['id'] == int(zone_id):
                data['games'].remove(i)
    with open("/data/ProjectDM/group/server_list.json", 'w+') as f:
        json.dump(data, f, indent=4, separators=(',', ': '), ensure_ascii=False)
        

def update_json(mzone, cozone_list):
    data = get_data("/data/ProjectDM/group/server_list.json")
    backup_file("json", "server_list.json")
    
    m_server = next((s for s in data['servers'] if s['id'] == mzone), None)
    if m_server:
        for s in data['servers']:
            if s['id'] in cozone_list:
                s['urls_game'] = m_server['urls_game']

    with open("/data/ProjectDM/group/server_list.json", 'w+') as f:
        json.dump(data, f, indent=4, separators=(',', ': '), ensure_ascii=False)

