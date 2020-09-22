//
//  ContentView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 06/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @State private var showingAlert = false
    @State private var startEdit = false
    
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
                                               }

                        Spacer()
                        

                        NavigationLink(destination: DrinkList())
                        {
                            Text("Add drink")
                                .foregroundColor(Color.white)
                                .bold()
                                .padding(.all , 10)
                                .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.gray, lineWidth: 4))
                                .background(Color.black)
                                .cornerRadius(20)
                                .shadow(radius: 5)
                        }.padding(.leading, 10)
                    }.padding(.horizontal)


                  
                
                    
                        
                    LiquorCabinetView(userDrinks: self.user.userDrinks, edit: $startEdit)
                               
                    
                        
                       
                    HStack{
                        Button(action: {
                            self.startEdit.toggle()
                        }, label: {
                            startEdit == false ? Text("Edit") : Text ("Done")
                        })
                        Spacer()
                        
                        if (startEdit){
                            Button(action: {
                                self.showingAlert = true
                            }) {
                                Text("Remove all")
                                    .foregroundColor(.red)
                            }
                            .alert(isPresented: $showingAlert, content: {
                                Alert(title: Text("Remove all"), message: Text("Are you sure you want to remove all your drinks?"), primaryButton: .default(Text("No")), secondaryButton: .destructive(Text("Yes"), action: {
                                    self.user.userDrinks.removeAll()
                                    saveUser()
                                    self.startEdit = false
                                }))
                            })
                        }

                    }.padding(.horizontal, 25)

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
    
    @Binding var edit:Bool
    
//    let left:Int
    

//    init(userDrinks:[String], edit:Bool) {
//        self.userDrinks = userDrinks
//        self.edit = edit
//        self.left = userDrinks.count % 3
//    }
    

    
    var body: some View {
      
      
        ScrollView(.vertical) {
            gridView(userDrinks: self.userDrinks, edit: $edit)
//            if (left == 0){
//                HStack{
//                    ForEach(0..<3, id: \.self){ j in
//                        cabinetDrinkView(drinkName: self.userDrinks[self.userDrinks.count - 3 + j], index: self.userDrinks.count - 3 + j)
//                        if (j != 2)
//                        {
//                            Spacer()
//                        }
//                    }
//                }
//                HStack{
//                    Image(systemName: "plus.circle.fill").foregroundColor(.green).imageScale(.large)
//                    Spacer()
//                }
//            }
//            else{
//                HStack{
//                    ForEach(self.userDrinks.count - left..<self.userDrinks.count, id: \.self){ j in
//                        cabinetDrinkView(drinkName: self.userDrinks[j], index: j)
//                        Spacer()
//                    }
//                    Image(systemName: "plus.circle.fill").foregroundColor(.green).imageScale(.large)
//                    Spacer()
//
//                }
//            }
        }
    
    }
}

    

struct cabinetDrinkView: View {
    
    let drinkName:String
    let index:Int
    
  
    @State var fullText = false
    @Binding var edit:Bool
    
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
                    .opacity(self.edit == false ? 1: 0.3)
                if (self.edit){
                    Image(systemName: "minus.circle.fill").foregroundColor(.red).imageScale(.large)
                        .offset(x: -30, y: -30)
                        .frame(alignment: .topLeading)
                        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        self.user.userDrinks.remove(at: index)
                        saveUser()
                    })
                }
            }.padding(.horizontal)
            Text(drinkName)
                .layoutPriority(1)
                .frame(width: 80 ,height: self.fullText == false ? 30 : .none)
                .multilineTextAlignment(.center)
                .opacity(self.edit == false ? 1: 0.3)
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    self.fullText.toggle()
                })
        }.padding(.all, 5)
    }
}

struct gridView: View {
    
    var userDrinks:[String]
    
    @Binding var edit:Bool
    
    func userDrinksLenght() -> Int {
        return Int(ceil(Double(self.userDrinks.count) / 3.0))
    }
    
    var body: some View {
        ForEach(0..<userDrinksLenght(), id: \.self) { i in
            HStack(alignment: .top){
                ForEach(min(i*3, self.userDrinks.count)..<min((i*3)+3, self.userDrinks.count), id: \.self){ j in
                    Spacer()
                    cabinetDrinkView(drinkName: self.userDrinks[j], index: j, edit: $edit)
                    Spacer()
                }
            }
        }
    }
}
