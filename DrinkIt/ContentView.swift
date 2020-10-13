//
//  ContentView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 06/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    
    @State private var startEdit = false
    
    //use to start the app with user guide
    @State var startGuide:Bool
    
    @EnvironmentObject var user:User
    
    
    // stop edit the liquer cabinet
    private func stopEdit() {
        self.startEdit = false
    }
        
    var body: some View {
        NavigationView{
            ZStack{
                
                DesignStyle.backgroundStyle().edgesIgnoringSafeArea(.all)
                    
                
               
                // full start view
                VStack{

                    // info and start guide button
                    InfoButtonView(startGuide: $startGuide)
                        .padding(.top, 2)
                    
                    // app title image
                    Image("DrinkIt white")
                        .resizable()
                        .scaledToFit()
                        .frame(alignment: .top)
            
                    HStack{
                        //show all cocktail button
                        NavigationLink(destination: CocktailsList(addToFavorite: user.userFavoriteCocktails)){
                            ButtonLableStyle.addStyle(lable: "All Cocktails")
                        }
                        
                
                        Spacer()
                        
                        //add drink button
                        NavigationLink(destination: DrinkList(categoriesOrList: user.drinksViewPriority)){
                            ButtonLableStyle.addStyle(lable: "Add drink")
                        }
                    }.padding(.horizontal)
                    
                    //liquor cabinet and grid view
                    LiquorCabinetView(userDrinks: self.user.userDrinks, edit: $startEdit)
                        .onDisappear(perform: stopEdit)
                               
                    //edit cabinet buttons bar
                    EditCabinetButtonsBar(startEdit: self.$startEdit)

                    //search cocktail button - depending on user drinks
                    NavigationLink(destination: CocktailsList(filterAcordingToUserDrinks: true, addToFavorite: user.userFavoriteCocktails)){
                        ButtonLableStyle.addStyle(lable: "Search Cocktails")
                    }
                    .padding(2)
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

    var body: some View {
        HStack{
            Button(action: {
                self.startEdit.toggle()
            }, label: {
                self.startEdit == false ? Text("Edit") : Text ("Done")
            })
            Spacer()
            
            if (self.startEdit){
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
                        AppDelegate.staticSaveContext(context: self.managedObjectContext)
                        self.startEdit = false
                    }))
                })
            }
            
        }.padding(.horizontal, 25)
    }
}

