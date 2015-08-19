package org.gamestartschool.codemage;

import java.net.URISyntaxException;
import java.util.List;

public class Main {

	public enum EDummyEnchantmentBinding implements IEnchantmentBinding {
		
		//These values are nonsense atm, replace them with minecraft'y versions please
		
		WOODEN_SWORD,
		WOODEN_AXE,
		WOODEN_PICKAXE,
		
		STONE_SWORD,
		STONE_AXE,
		STONE_PICKAXE,
		
		IRON_SWORD,
		IRON_AXE,
		IRON_PICKAXE,
		
		DIAMOND_SWORD,
		DIAMOND_AXE,
		DIAMOND_PICKAXE,
		
		WOODEN_HELMET,
		WOODEN_CHESTPLATE,
		WOODEN_SHIELD,
		
		EGG,
		LAVA_BUCKET
	}
	
	public enum EDummyEnchantmentTrigger implements IEnchantmentTrigger {
		// I don't know how minecraft works, but you get the idea here

		PRIMARY,
		SECONDARY,
		PREDAMAGE,
		POSTDAMAGE,
		JUMP,
		EQUIPPED,
		AQUIRED,
		
	}

	
	static String meteorIp = "localhost";
	static int meteorPort = 3000;
	static String meterUsername = "gss";
	static String meteorPassword = "asdfasdf";
	
	static String minecraftPlayerId = "GameStartSchool";

	public static void main(String[] args) throws InterruptedException, URISyntaxException {
		
		//Example usage of the CodeMageDDP Provider object
		CodeMageDDP ddp = new CodeMageDDP(meteorIp, meteorPort);
		ddp.connect(meterUsername, meteorPassword);
		
		//Can't rely on this list being up-to-date during gameplay... need a better architecture
		List<MongoEnchantment> enchantments = ddp.getEnchantments(minecraftPlayerId);
		
		//Lets pretend I swing my wooden sword...
		for (IEnchantment e : enchantments) {
			if(EDummyEnchantmentTrigger.PRIMARY.equals(e.getTrigger()) 
					&& EDummyEnchantmentBinding.WOODEN_SWORD.equals(e.getBinding())){
				for (ISpell spell : e.getSpells()) {
					System.out.println("Running code!: \n" + spell.getCode());
				}
			
			}
		}
		System.out.println("Done!");
	}
	
	
}
