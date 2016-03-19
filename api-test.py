import requests
import datetime

def _url(path):
  return 'http://localhost:3000' + path

#To GET the entire list
def get_todo():
    return requests.get(_url('/todos/'))

#To GET a specific record given the ID
def get_id(todo_id):
    return requests.get(_url('/todos/%s/' %todo_id))

#To ADD a new record
def add_todo(name, note ="" ):
    return requests.post(_url('/todos/'), json={
        'name': name,
        'note': note,
        })

#To update an existing record given the ID
def update_todo(todo_id, name, note):
    url = _url('/todos/%s/' %todo_id)
    return requests.put(url, json={
        'name': name,
        'note': note,
        })

#To delete a specific record given the ID
def delete_todo(todo_id):
    return requests.delete(_url('/todos/%s/' %todo_id))

 
resp = get_todo()
if resp.status_code != 200:
  resp.raise_for_status(); # Display on console what went wrong 
if resp.json():
  print('Output of GET /path/')
  for todo_item in resp.json():
    print ('Topic: {} - Note: {} - ID: {}'.format(todo_item['name'], todo_item['note'], todo_item['_id']))
  print('---------------------------------------------------')

resp = add_todo ("This is a new topic", "description of new topic")
if resp.status_code != 200:
  resp.raise_for_status();
else: 
  print('Output of POST /path/ \nCreated new task with ID: {}'.format(resp.json()["_id"]))
  print('Topic: {} - Note: {} '.format(resp.json()["name"], resp.json()["note"]))
  print('---------------------------------------------------')
  id_num = resp.json()["_id"]

resp = get_id(id_num)
if resp.status_code != 200:
  resp.raise_for_status();
elif resp.json():
  print('Output of GET /path/id')
  print('Topic: {} - Note: {} - ID: {}'.format(resp.json()['name'], resp.json()['note'], resp.json()['_id']))
  print('---------------------------------------------------')
  
resp = update_todo(id_num, "This is an update to topic", "this is an update")
if resp.status_code != 200:
  resp.raise_for_status();
else: 
  print('Output of PUT /path/id') 
  print ('Updated task with ID {}'.format(resp.json()["_id"]))
  print('Topic: {} - Note: {} '.format(resp.json()["name"], resp.json()["note"]))
  print('---------------------------------------------------')

##for todo_item in resp.json():
 ## id_num = todo_item['_id']
resp = delete_todo(id_num)
if resp.status_code != 200:
  resp.raise_for_status();
else: 
    print('Output of DELETE /path/id') 
    print('Removed task from list with ID%s' %id_num)
    print('---------------------------------------------------')
