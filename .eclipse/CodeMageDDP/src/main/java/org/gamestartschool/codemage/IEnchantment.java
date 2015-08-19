package org.gamestartschool.codemage;

public interface IEnchantment {
	public String getName();
	public String getMinecraftPlayerId();
	public IEnchantmentBinding getBinding();
	public IEnchantmentTrigger getTrigger();
	public ISpell[] getSpells();
}
