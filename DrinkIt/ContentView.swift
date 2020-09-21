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

//                    Text("DrinkIt").offset(y: -50).font(.title)
                    Image("DrinkIt")
                        .resizable()
                        .scaledToFit()
                        .frame(alignment: .top)

            

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
                        
                        Button(action: {
                            self.user.userDrinks.removeAll()
                            saveUser()
                        }){
                            Text("Remove all")
                        }
                        
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
                    
                    
                        
                       

              

                        NavigationLink(destination: CocktailsList(filterSearch: true))
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
                        }.padding([.top, .leading, .trailing])
                
               



                
                }.navigationBarHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                






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
    
    func userDrinksLenght() -> Int {
        return Int(ceil(Double(self.userDrinks.count) / 3.0))
    }
    
    var body: some View {
      

        ScrollView(.vertical) {
            ForEach(0..<userDrinksLenght(), id: \.self) { i in
                HStack(alignment: .top){
                    ForEach(min(i*3, self.userDrinks.count)..<min((i*3)+3, self.userDrinks.count), id: \.self){ j in
                        Spacer()
                        cabinetDrinkView(drinkName: self.userDrinks[j], index: j)
                        Spacer()
                       
                    }
                }
            }
        }
//        .onAppear(perform: {
//            UITableView.appearance().backgroundColor = UIColor.clear
//        })
    
    }
}

    

struct cabinetDrinkView: View {
    
    let drinkName:String
    let index:Int
    
    @State var longPress = false
    @State var fullText = false
    
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
        VStack(alignment: .center){
            ZStack{
                ImageView()
                    .opacity(self.longPress == false ? 1: 0.3)
                if (self.longPress){
                    Image(systemName: "minus.circle.fill").foregroundColor(.red).imageScale(.large)
                        .offset(x: -30, y: -30)
                        .frame(alignment: .topLeading)
                        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        self.user.userDrinks.remove(at: index)
                        saveUser()
                        self.longPress = false
                    })
                }
            }.padding(.horizontal)
            Text(drinkName)
                .layoutPriority(1)
                .frame(width: 80 ,height: self.fullText == false ? 30 : .none)
                .multilineTextAlignment(.center)
                .opacity(self.longPress == false ? 1: 0.3)
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    self.fullText.toggle()
                })
        }.padding(.all, 5)
        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
            self.longPress = false
        })
        .onLongPressGesture{
            self.longPress = true
        }
        
    }
}
