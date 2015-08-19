package org.gamestartschool.codemage;

import java.util.List;

interface IUser {

	String getMinecraftUserId();

	List<ISpell> getSpells();
	
	List<IEnchantment> getEnchantments();
}