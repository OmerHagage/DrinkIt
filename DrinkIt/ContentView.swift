//
//  ContentView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 06/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
 
    @EnvironmentObject var user:User
         
    
         
    
    
    
    
    
        
    var body: some View {
     
        
        NavigationView{
            
            VStack{

                Text("DrinkIt").offset(y: -50).font(.title)
                Spacer()
                
                HStack{

                    NavigationLink(destination: CocktailsList())
                                       {
                                           Text("All Cocktails")
                                       .foregroundColor(Color.white)
                                                   .bold()
                                                   .padding(.all , 10)
                                                   .padding(.horizontal , 0)
                                                   .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.gray, lineWidth: 4))
                                                   .background(Color.black)
                                                   .cornerRadius(20)
                                                   .shadow(radius: 10)
                                           }.padding(.horizontal, 20)
                    
                    Spacer()
                    
                    NavigationLink(destination: DrinkList())
                    {
                        Text("Add drink")
                            .foregroundColor(Color.white)
                            .bold()
                            .padding(.all , 10)
                            .padding(.horizontal , 0)
                            .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.gray, lineWidth: 4))
                            .background(Color.black)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    }.padding(.horizontal, 20)
                    
                }
                    
                Spacer()

                
            
                List {
                
                    ForEach(0..<self.user.userDrinks.count){ i in
                        HStack {
                            Button(action: {

                            }) {
                                Text(self.user.userDrinks[i])
                            }
                        }.padding()
                    }
                }
                .padding()
                .background(/*@START_MENU_TOKEN@*/Color.orange/*@END_MENU_TOKEN@*/)
                .cornerRadius(20)
                .padding()
                
                
                
                
                
                
                
                Spacer()

                HStack{
                  

                    Spacer()

                    NavigationLink(destination: CocktailsList())
                    {
                        Text("Search Cocktails")
                        .bold()
                        .padding(.all , 10)
                        .padding(.horizontal , 40)
                        .overlay(RoundedRectangle(cornerRadius:20).stroke(lineWidth: 3))
                        .background(Color.yellow)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    }
                    Spacer()
                }
                
                
                
                 Spacer()
            }
            
            
    
           
            
            
        }
  
        
    }
    

    
 
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




