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
                                                   .shadow(radius: 5)
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
                            .shadow(radius: 5)
                    }.padding(.horizontal, 20)
                }



            
                
                LiquorCabinetView(userDrinks: self.user.userDrinks)
               
                
                    
                   

          

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
                    }.padding()
            
           



            
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
            ForEach(0..<(self.userDrinks.count/3)+1, id: \.self) { i in
                HStack(alignment: .top){
                    ForEach(min(i*3, self.userDrinks.count)..<min((i*3)+3, self.userDrinks.count), id: \.self){ j in
                        cabinetDrinkView(drinkName: self.userDrinks[j], index: j)
                    }
                }
            }
        }
        .scaledToFit()
        .onAppear(perform: {
            UITableView.appearance().backgroundColor = UIColor.clear
        })
    }
}

    

struct cabinetDrinkView: View {
    
    let drinkName:String
    let index:Int
    
    @State var longPress = false
    
    @EnvironmentObject var user:User
    
    var body: some View {
        VStack(alignment: .center){
            ZStack{
                ImageView()
                    .opacity(self.longPress == false ? 1: 0.3)
                if (self.longPress){
                    Image(systemName: "minus.circle.fill").foregroundColor(.red).imageScale(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/).offset(x: -50, y: -50)
                        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        self.user.userDrinks.remove(at: index)
                        self.longPress = false
                    })
                }
            }.padding()
            Text(drinkName).multilineTextAlignment(.center).opacity(self.longPress == false ? 1: 0.3)
        }.padding(.horizontal, 5)
        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
            self.longPress = false
        })
        .onLongPressGesture{
            self.longPress = true
        }
        
    }
}
