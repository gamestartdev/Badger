package org.gamestartschool.codemage;

import java.util.List;

public interface IEnchantment {
	public String getName();
	public IEnchantmentBinding getBinding();
	public IEnchantmentTrigger getTrigger();
	public List<ISpell> getSpells();
}
