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
    @State var appDarkMode:Bool
    
    //use to start the app with user guide
    @State var startGuide:Bool
    
    @State var pressed:Bool = false
    
    @EnvironmentObject var user:User
    
    @EnvironmentObject var model:Model
    

    
    // stop edit the liquer cabinet
    private func stopEdit() {
        self.startEdit = false
    }
        
    var body: some View {
        NavigationView{
            ZStack{
                
//                DesignStyle.backgroundStyle().edgesIgnoringSafeArea(.all)
                    
                
               
                // full start view
                VStack{

                    // info and start guide button
                    BarButtonView(pressed: self.$pressed, startGuide: self.$startGuide)
                        .padding(.top, 2)
                    
                    // app title image
                    Image("DrinkIt")
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
                
                HalfModalView(isShown: self.$pressed, modalHeight: 200){
                    Menu(isShown: self.$pressed, appDarkMode: self.$appDarkMode, startGuide: self.$startGuide)
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


struct BarButtonView: View {
    @Binding var pressed:Bool
    @Binding var startGuide:Bool
    
    var body: some View {
        HStack{
            NavigationLink(
                "",
                destination: StartGuide(startGuide: self.$startGuide, firstTime: true),
                isActive: self.$startGuide)
            
            Spacer()
            
            Button(action: {
                self.pressed = true
            }, label: {
                Image(systemName: "gear").padding(.trailing, 20)
                    .foregroundColor(.primary)
            })

            
        }
    }
}


struct StartGuide: View {
    @Binding var startGuide:Bool
    @State var firstTime = false
    
    
    var body: some View{
        VStack{
           
            Text("Start Guide").font(.title)
               
            
            // dismiss start guide view
            Button(action: {
                self.startGuide = false
            }, label: {
                Text("I am old")
            })
            .navigationBarHidden(firstTime)
        }
    }
}



struct Menu: View {
    @Binding var isShown:Bool
    @Binding var appDarkMode:Bool
    
    //use to start the app with user guide
    @Binding var startGuide:Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var user:User
    
    var body: some View{
        VStack{
            XButton(isShown: self.$isShown)
                .padding(.top)
                .padding(.bottom, 5)
            Divider()
            Toggle(isOn: self.$appDarkMode, label: {
                HStack{
                    Image(systemName: "moon.fill").font(.title)
                        .rotationEffect(.init(degrees: appDarkMode ? 0 : -450))
                    
                    Text("Dark Mode").padding(.horizontal)
                }
            }).onReceive([self.appDarkMode].publisher.first(), perform: { val in
                if (!val){
                    UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = .light
                    
                }
                else{
                    UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = .dark
                }
                self.user.darkMode = val
            })
            
            Divider()
            
            NavigationLink(
                destination: StartGuide(startGuide: self.$startGuide),
                label: {
                    HStack{
                        Image(systemName: "info.circle").font(.title)
                        Text("Show start guide")
                            .padding(.horizontal)
                        Spacer()
                    }.foregroundColor(.primary)
                    
                })
        }
        .onDisappear(perform: {
            AppDelegate.staticSaveContext(context: self.managedObjectContext)
        })
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

