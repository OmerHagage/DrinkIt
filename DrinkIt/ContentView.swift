//
//  ContentView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 06/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
 
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var user:User
    
    func saveUser(){
        do{
            try self.managedObjectContext.save()
        }
        catch{
            print(error)
            exit(EXIT_FAILURE)
        }
    }

        
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

                
//                LiquorCabinetView(userDrinks: self.user.userDrinks!)
            
            List {

                ForEach(self.user.userDrinks!,  id: \.self){ drinkName in
                    HStack {
                        Button(action: {
                            print("second")
                        }) {
                            HStack{
                                Text(drinkName)
                                Spacer()
                                ImageView()
                            }
                        }.buttonStyle(BorderlessButtonStyle())
                            .foregroundColor(.black)
                    }.padding()
                }.onDelete(){ index in
                    self.user.userDrinks!.remove(at: index.first!)
                    self.saveUser()
                }
            }

            .padding()
            .background(Color.black)
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
        ContentView().environmentObject(User(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext))
    }
}






struct LiquorCabinetView: View {
    var userDrinks:[String]
    
    
    var body: some View {
      
        
        List {
            ForEach(0..<self.userDrinks.count, id: \.self) { i in
                HStack{
                    ForEach(min(i*3, self.userDrinks.count)..<min(i+3, self.userDrinks.count), id: \.self){ j in
                        Text(self.userDrinks[j])
                    }
                }
            }
        }
    }
}

//                       ForEach(self.userDrinks,  id: \.self){ drinkName in
//                           HStack {
//                               Button(action: {print("omeer")}){ Text("omer")}.foregroundColor(.gray).buttonStyle(BorderlessButtonStyle())
//                               Button(action: {
//                                   print("second")
//                               }) {
//                                   HStack{
//                                       Text(drinkName)
//                                       Spacer()
//                                       ImageView()
//                                   }
//                               }.buttonStyle(BorderlessButtonStyle())
//                           }.padding()
////                       }.onDelete(){ index in
////                           self.userDrinks.remove(at: index.first!)
////                           self.saveUser()
////                       }
//                   }
//
//                   .padding()
//                   .background(Color.black)
//                   .cornerRadius(20)
//                   .padding()
    
