# Puppet

## Puppet Agent command reference

- `cat $(puppet agent --configprint resourcefile)` - List all resources managed by puppet.
- `cat $(puppet agent --configprint agent_disabled_lockfile)` - Check whether the puppet agent is disabled and why.
- `puppet agent --disable "Who disabled puppet agent, when and why."` - Disable the puppet agent.
- `cat /opt/puppetlabs/puppet/cache/state/classes.txt` - List all classes applied to the current node. Note the file location may be configured differently.
- `puppet agent --test --noop` - Run the puppet agent once in noop mode without starting the daemon, to check what would be applied.
