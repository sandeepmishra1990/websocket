package com.org;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;

import javax.servlet.http.HttpSession;
import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint("/chatwithme/{address}")
public class Chatendpoint {

	
	 private static Queue<Session> queue = new ConcurrentLinkedQueue<Session>();
	 public  int counter=1;
	 
	@OnOpen
	public void open(Session session,@PathParam(value = "address") String address) throws IOException
	{
		System.out.println("adrees in open is :"+address);		
		
		queue.add(session);
		session.getUserProperties().put("address", address);
		System.out.println(counter++);
		System.out.println("new session opened id:"+session.getId() +"address"+address);//comment out before deployment
		
		}
	
	
	@OnClose
	public void close(Session session)
	{
		
			queue.remove(session);
		System.out.println("session closed id:"+session.getId());//comment out before deployment
	
	}
	
	@OnMessage
	public void onMessage(Session session,String msg) throws IOException
	{
		ArrayList<Session> closedsessionlist=new ArrayList<Session>();
		/*System.out.println("message from on message"+msg);
		session.getBasicRemote().sendText(msg);*/
		String currentaddress = (String) session.getUserProperties().get("address");
		for(Session ses: queue)
		{
			if(!ses.isOpen() )
				closedsessionlist.add(ses);
			else
			{
				if(ses.getUserProperties().get("address").equals(currentaddress)){
				try {
					//triggers when client send message to this endpoint 
                    //and it will redirect it to its all connected clients at
                    // the same address i.e. single client message broadcasting to all clients at
					//same address
					//session.getBasicRemote().sendObject(msg); 
					ses.getBasicRemote().sendText(msg);
					System.out.println("sending message to clients just recieved");  //remove before deployment
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				}
				
			}
		}
	}
	
	
	
	
}
