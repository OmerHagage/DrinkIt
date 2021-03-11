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
    
    
    @State var showDrinkInfo:Bool = false
    
    @State var infoDrink = Drink()
    

    
    // stop edit the liquer cabinet
    private func stopEdit() {
        self.startEdit = false
    }
        
    var body: some View {
        NavigationView{
            ZStack{
                
                // backgound color
                DesignStyle.backgroundStyle().edgesIgnoringSafeArea(.all)
                    
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
                            ButtonLableStyle.addStyle(lable: "Add Drinks")
                        }
                    }.padding(.horizontal)
                    
                    //liquor cabinet and grid view
                    LiquorCabinetView(userDrinks: self.user.userDrinks, edit: $startEdit, showDrinkInfo: $showDrinkInfo, infoDrink: $infoDrink)
                        .onDisappear(perform: stopEdit)
                               
                    //edit cabinet buttons bar
                    EditCabinetButtonsBar(startEdit: self.$startEdit)

                    //search cocktail button - depending on user drinks
                    NavigationLink(destination: CocktailsList(filterAcordingToUserDrinks: true, addToFavorite: user.userFavoriteCocktails)){
                        ButtonLableStyle.addStyle(lable: "View Cocktails You Can Make")
                    }
                    .padding(2)
                    .padding(.bottom, 2)
                }
                
                HalfModalView(isShown: self.$pressed, modalHeight: 200){
                    Menu(isShown: self.$pressed, appDarkMode: self.$appDarkMode, startGuide: self.$startGuide)
                }
                
                HalfModalView(isShown: self.$showDrinkInfo, modalHeight: 200){
                    DrinkInfoView(showDrinkInfo: self.$showDrinkInfo, infoDrink: self.$infoDrink, mainCabinet: true)
                    
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
    @State var termAgree = false
    @State var showTerms = false
    
    
    var body: some View{
        VStack{
            Divider()
            ScrollView{
                VStack(alignment: .leading, spacing: 10){
                    
                    Guide()
                    
                    if (self.firstTime){
                        Divider().padding(.vertical, 20)
                    }
                    
                    Button(action: {
                        self.showTerms.toggle()
                    }, label: {
                        HStack{
                            Text("Privacy Policy and Terms & Conditions")
                            Image(systemName: self.showTerms ? "arrowtriangle.up.circle" : "arrowtriangle.down.circle")
                            Spacer()
                        }
                    }).padding(.top, 10)
                    
                    if (self.showTerms){
                        PrivacyAndTerms().onTapGesture {
                            self.showTerms.toggle()
                        }
                    }
            
            // dismiss start guide view
                    if (self.firstTime){
                        
                            Toggle("I agree to the Privacy Policy and Terms & Conditions", isOn: self.$termAgree)
                        
                           
                            
                            HStack(spacing: 20){
                                Spacer()
                                
                                VStack(spacing: 20){
                                    Text("Are you of legal drinking age?").font(.headline)
                                    
                                    HStack(spacing: 100){
                                        Button(action: {
                                            self.startGuide = false
                                        }){
                                            ButtonLableStyle.addStyle(lable: "Yes")
                                        }.disabled(!self.termAgree)
                                        .opacity(self.termAgree ? 1 : 0.5)
                                        
                                        Button(action: {
                                            exit(0)
                                        }){
                                            ButtonLableStyle.addStyle(lable: "No")
                                        }
                                    }
                                }
                                   
                                Spacer()
                            }.padding(.vertical, 20)
                        }
                }.padding(.horizontal, 10)
            }
        }
        .navigationBarBackButtonHidden(firstTime)
        .navigationBarTitle("Start Guide")
    }
}



struct Guide: View {
    
    var body: some View{
        Text("Welcome to DrinkIt, the place where you can make cocktails at ease, at your home, at your friend’s house or anywhere else with the ingredients you already have!").font(.system(size: 22)).bold().padding(.bottom, 5)
        
        BulletedGuideText(text: "Add all the drinks you have at home.")
        
        Image("addDrinksGuide")
            .resizable()
            .scaledToFit()
            
        BulletedGuideText(text: "Search for all the cocktails you can make with those drinks.")
        
        Image("findCocktailsGuide")
            .resizable()
            .scaledToFit()
        
        BulletedGuideText(text: "Make the cocktail with an easy recipe.")
        
        HStack{
            Spacer()
            Text("Enjoy!").font(.title).bold()
            Spacer()
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
                if (val){
                    UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = .dark
                }
                else{
                    UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = .light
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

                        AppDelegate.staticSaveContext(context: self.managedObjectContext)
                        self.startEdit = false
                    }))
                })
            }
            
        }.padding(.horizontal, 25)
    }
}

