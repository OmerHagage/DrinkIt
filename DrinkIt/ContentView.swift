//
//  ContentView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 06/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    @State private var startEdit = false
    
    //use to start the app with user guide
    @State var startGuide:Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var user:User

    
    
    static func saveUser(x: NSManagedObjectContext){
        do{
            try x.save()
        }
        catch{
            print(error)
            exit(EXIT_FAILURE)
        }
    }

        
    var body: some View {
        NavigationView{
            ZStack{
//              Color.white.opacity(0.85).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
               
                // full start view
                VStack{

                    // info and start guide button
                    InfoButtonView(startGuide: $startGuide)
                    
                    // app title image
                    Image("DrinkIt")
                        .resizable()
                        .scaledToFit()
                        .frame(alignment: .top)
            
                    HStack{
                        //show all cocktail button
                        NavigationLink(destination: CocktailsList()){
                            ButtonLableStyle.addStyle(lable: "All Cocktails")
                        }
                        Spacer()
                        
                        //add drink button
                        NavigationLink(destination: DrinkList()){
                            ButtonLableStyle.addStyle(lable: "Add drink")
                        }
                    }.padding(.horizontal)
                    
                    //liquor cabinet and grid view
                    LiquorCabinetView(userDrinks: self.user.userDrinks, edit: $startEdit)
                               
                    //edit cabinet buttons bar
                    EditCabinetButtonsBar(startEdit: self.$startEdit)

                    //search cocktail button - depending on user drinks
                    NavigationLink(destination: CocktailsList(filterSearch: true)){
                        ButtonLableStyle.addStyle(lable: "Search Cocktails")
                    }.padding([.top, .leading, .trailing])
                }
            }
            
            .navigationBarHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environmentObject(User(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext))
//    }
//}


struct InfoButtonView: View {
    @Binding var startGuide:Bool
    
    var body: some View {
        HStack{
            Spacer()
            Image(systemName: "info.circle")
                .onTapGesture(count: 1, perform: {
                    self.startGuide = true
                }).padding(.trailing, 20)
                .sheet(isPresented: $startGuide, content: {
                    
                    Text("Start Guide").font(.title)
                    
                    // dismiss start guide view
                    Button(action: {
                        startGuide = false
                    }, label: {
                        Text("Done")
                    })
                })
        }
    }
}


struct EditCabinetButtonsBar: View {
    @Binding var startEdit:Bool
    
    @State private var showingAlert = false
    
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
                        
                        //todo: check this
//                        ContentView.saveUser(x: self.managedObjectContext)
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                        self.startEdit = false
                    }))
                })
            }
            
        }.padding(.horizontal, 25)
    }
}

