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
    
    //use to start the app with user guide
    @State var startGuide:Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var user:User
    
//    @Environment(\.presentationMode) var startGuidMode: Binding<PresentationMode>
    
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
                
                ZStack{
//                    Color.white.opacity(0.85).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                    
                
              
                VStack{

//                    Text("DrinkIt").offset(y: -50).font(.title)
                    HStack{
                        Spacer()
                        Image(systemName: "info.circle")
                            .onTapGesture(count: 1, perform: {
                                self.startGuide = true
                            }).padding(.trailing, 20)
                            .sheet(isPresented: $startGuide, content: {

                                Text("Start Guide").font(.title)
                                Button(action: {
                                    startGuide = false
                                }, label: {
                                    Text("Done")
                                })
                            })
                    }
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


                  
                
                    Spacer()
                        
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
          
                
            }.navigationViewStyle(StackNavigationViewStyle())
//            .navigationBarItems(trailing: Image(systemName: "info.circle"))
    }
    

    
 
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environmentObject(User(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext))
//    }
//}






struct LiquorCabinetView: View {
    var userDrinks:Set<String>
    
    @Binding var edit:Bool
    
//    let left:Int
    

//    init(userDrinks:[String], edit:Bool) {
//        self.userDrinks = userDrinks
//        self.edit = edit
//        self.left = userDrinks.count % 3
//    }
    

    
    var body: some View {
      
      
        ScrollView(.horizontal, showsIndicators: false){
        
            gridView(drinks: self.userDrinks, editt: $edit)
            Spacer()
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
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6)
    
    }
}

    

struct cabinetDrinkView: View {
    
    let drinkName:String
    
    
  
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
                ImageView(imageName: "jagermeister_icon")
                    .opacity(self.edit == false ? 1: 0.3)
                if (self.edit){
                    Image(systemName: "minus.circle.fill").foregroundColor(.red).imageScale(.large)
                        .offset(x: -30, y: -30)
                        .frame(alignment: .topLeading)
                        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        self.user.userDrinks.remove(drinkName)
                        saveUser()
                    })
                }
            }.padding(.horizontal)
            Text(drinkName)
                .layoutPriority(1)
                .frame(width: self.fullText == false ? 100 : .none ,height: 30)
                .multilineTextAlignment(.center)
                .opacity(self.edit == false ? 1: 0.3)
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    self.fullText.toggle()
                })
        }
        .padding([.top, .leading, .trailing], 10.0)
    }
}

struct gridView: View {
    
    var userDrinks:[[String]]
    
    @Binding var edit:Bool
    
    init(drinks:Set<String>, editt:Binding<Bool>) {
        self.userDrinks = gridView.toArray(drinks: drinks)
        self._edit = editt
        
    }
    
    
    
    static func toArray(drinks:Set<String>) -> [[String]] {
        var count = 0
        var arr = [[String]]()
        var innerArr = [String]()
        for item in drinks.sorted() {
            if (count < 4){
                innerArr.append(item)
                count += 1
            }
            if (count == 4) {
                arr.append(innerArr)
                innerArr = [String]()
                count = 0
            }
        }
        arr.append(innerArr)
        return arr
    }
    
    var body: some View {

//        HStack{
//            ForEach(0..<userDrinksLenght(), id: \.self) { i in
//
//                VStack(alignment: .center){
//                    ForEach(min(i*4, self.userDrinks.count)..<min((i*4)+4, self.userDrinks.count), id: \.self){ j in
//    //                    Spacer()
//
////                        cabinetDrinkView(drinkName: self.userDrinks[j], edit: $edit)
//                        cabinetDrinkView(drinkName: "self.userDrinks[j]", edit: $edit)
//
////                            .frame(width: UIScreen.main.bounds.width * 0.3, height: geo.size.height * 0.23)
//
//                        Spacer()
//                    }
//                }
//            }
//        }
       

        HStack{
            ForEach(self.userDrinks, id: \.self){ chunk in
                VStack{
                    ForEach(chunk, id: \.self){ drink in
                        cabinetDrinkView(drinkName: drink, edit: self.$edit)
                        Spacer()
                    }
                    
                }
            }
        }
    }
}
