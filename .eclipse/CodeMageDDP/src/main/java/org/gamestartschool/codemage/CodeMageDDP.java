package org.gamestartschool.codemage;


import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.keysolutions.ddpclient.DDPClient;
import com.keysolutions.ddpclient.DDPListener;
import com.keysolutions.ddpclient.UsernameAuth;
import ch.lambdaj.function.matcher.Predicate;
import static ch.lambdaj.Lambda.*;

public class CodeMageDDP {
	
	private DDPClient ddpClient;
	private List<ACodeMageCollection<?>> subscriptions = new ArrayList<ACodeMageCollection<?>>();

	public CodeMageDDP(String meteorServerIp, Integer meteorServerPort) throws URISyntaxException {
		ddpClient = new DDPClient(meteorServerIp, meteorServerPort);
	}
	
	public boolean isReady() { 
		for (ACodeMageCollection<?> collection : subscriptions) {
			if(!collection.isReady())return false;
		}
		return true;
	}
	
	public void connect(String username, String password) throws InterruptedException {
		ddpClient.connect();
		reportCodeMageServerStatus(CodeMageServerStatus.SUBSCRIBING);

		doLogin(username, password);
		Thread.sleep(200);
		
		createSubscription(CodeMageCollections.users);
		createSubscription(CodeMageCollections.enchantments);
		createSubscription(CodeMageCollections.spells);

		while(!isReady()){
			System.out.println("Not ready..");
			Thread.sleep(1000);
		}
		
		reportCodeMageServerStatus(CodeMageServerStatus.ACCEPTING_PLAYERS);
	}

	private void reportCodeMageServerStatus(CodeMageServerStatus status) {
		String dummyCodeMageServerIp = "127.0.0.1";
		String dummyCodeMageServerPort = "54175";
		ddpClient.call("codeMageServerStatus", new Object[]{ dummyCodeMageServerIp, dummyCodeMageServerPort, status } );
		System.out.println("Ready.");
	}
	
	private void createSubscription(ACodeMageCollection<?> collection) {
		subscriptions.add(collection);
		ddpClient.addObserver(collection);
		ddpClient.subscribe(collection.getName(), new Object[] {}, collection); //Passing in collection here means we get a call to "onReady" I believe?
	}

	private void doLogin(String username, String password) {
		UsernameAuth usernameAuth = new UsernameAuth(username, password);
		Object[] params = new Object[1];
		params[0] = usernameAuth;
		ddpClient.call("login", params, new DDPListener(){
			
			@Override
			public void onResult(Map<String, Object> resultFields) {
				super.onResult(resultFields);
				System.out.println("Logged in: "+resultFields);
			}
		});
	}

	public List<MongoEnchantment> getEnchantments(String minecraftPlayerId) {
		return filter(new EnchantmentsByPlayerId(minecraftPlayerId), CodeMageCollections.enchantments.getAll());
	}

	class EnchantmentsByPlayerId extends Predicate<MongoEnchantment> {

		private String minecraftPlayerId;

		public EnchantmentsByPlayerId(String minecraftPlayerId) {
			this.minecraftPlayerId = minecraftPlayerId;
		}

		@Override
		public boolean apply(MongoEnchantment e) {
			return minecraftPlayerId.equals(e.getMinecraftPlayerId());
		}
		
	}
}
