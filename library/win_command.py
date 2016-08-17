#!C:\\Python27\\python

# import some python modules that we'll use.  These are all
# available in Python's core

from ansible.module_utils.basic import *
import winrm


def main():
    module = AnsibleModule(
        argument_spec=dict(
            ip=dict(required=True, type='str'),
            username=dict(required=True, type='str'),
            password=dict(required=True, type='str'),
            command=dict(required=True, type='str')
        )
    )
    execute = run_command(module.params)
    module.exit_json(changed=execute, meta=module.params)


def run_command(data):
    print 'yessssssssssssssssssssssssssssssssss'
    s = winrm.Session(data['ip'], auth=(data['username'], data['password']))
    r = s.run_cmd('ipconfig', ['/all'])
    return r.status_code

if __name__ == '__main__':
    main()


