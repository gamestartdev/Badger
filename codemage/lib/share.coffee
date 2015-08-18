share.codeMageConstants = {}
share.codeMageConstants.tools = []
for adj in ['wooden', 'stone', 'iron', 'diamond']
  for tool in ['sword', 'axe', 'pickaxe']
    share.codeMageConstants.tools.push adj + "_" + tool
share.codeMageConstants.triggers = ['primary', 'secondary', 'predamage', 'postdamage', 'jump']
share.codeMageConstants.defaultCode = 'yell("OOPS")\ntime.sleep(2)\nspawnentity(player.x, player.y, player.z, "primed_tnt")'