//
//  DrinkList.swift
//  DrinkIt
//
//  Created by Omer Hagage on 06/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct DrinkList: View {
  @EnvironmentObject var dbDrinks:DBDrinks

  @State var drinkToAdd = Set<String>()
  @State var searchText:String = ""

  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @Environment(\.managedObjectContext) var managedObjectContext
  @EnvironmentObject var user:User

  @State var categoriesOrList:String

  @State var showDrinkInfo:Bool = false
  @State var infoDrink = Drink()

  @State var emptyAdd:Bool = false
  @State var showEditCategoriesOrListSheet:Bool = false

  /**
   searchBar filter function
   */
  private func filterSearch(drink: Drink) -> Bool {
    if self.searchText.isEmpty{
      return true
    }
    for word in drink.id.split(separator: " "){
      if word.lowercased().starts(with: self.searchText.lowercased()){
        return true
      }
    }
    return false
  }


  var body: some View {
    ZStack{
      DesignStyle.backgroundStyle().edgesIgnoringSafeArea(.all)

      VStack{

        HStack{
          Button(action: {
            // add chosen drinks to the user
            if (self.drinkToAdd.isEmpty){
              self.emptyAdd = true
            }
            else{
              self.user.userDrinks.formUnion(self.drinkToAdd)
              AppDelegate.staticSaveContext(context: self.managedObjectContext)
              self.presentationMode.wrappedValue.dismiss()
            }
          }) {
            ButtonLableStyle.addStyle(image: Image(systemName: "plus"),lable: " Add to your liquor cabinet")
          }
          .alert(isPresented: self.$emptyAdd, content: {
            Alert(title: Text("Add drinks"), message: Text("Please select drinks in order to add to your liquor cabinet"), dismissButton: .default(Text("OK")))
          })

          Spacer()

          Button(action: {
            self.showEditCategoriesOrListSheet = true
            UIApplication.shared.endEditing()
          }, label: {
            Image(systemName: "slider.horizontal.3").foregroundColor(.primary)
          })


        }.padding(.horizontal)


        // search bar
        SearchBar(text: $searchText).padding(.top)


        // Drinks list - show only drinks that the user don't have
        if (self.categoriesOrList == "Categories"){
          List{
            ForEach(self.dbDrinks.data.keys.sorted(), id: \.self){ category in
              VStack(alignment: .leading, spacing: 0){
                Text(category).font(.headline).fontWeight(.bold)
                  .padding(.leading)
                  .padding(.top, 3)
                ScrollView(.horizontal, showsIndicators: false){
                  HStack(spacing: 7){
                    ForEach(self.dbDrinks.data[category]!.filter(filterSearch(drink:))){
                      drink in
                      CategoryDrinkButtonView(drink: drink, drinkToAdd: self.$drinkToAdd, pressed: self.drinkToAdd.contains(drink.id) || self.user.userDrinks.contains(drink.id), showSheetDrinkInfo: self.$showDrinkInfo, infoDrink: self.$infoDrink)

                    }
                  }.padding()
                }.padding(.bottom, 3)
              }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
          }
          .padding(.top, 1)
          .gesture(DragGesture().onChanged { _ in
            UIApplication.shared.endEditing()
          })
          .onAppear(){
            UITableView.appearance().showsVerticalScrollIndicator = false
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
          }
        }
        else{
          ScrollView(.vertical, showsIndicators: true){
            VStack(spacing: 7){
              ForEach(self.dbDrinks.data.keys.sorted(), id: \.self){ category in
                ForEach(self.dbDrinks.data[category]!.filter(filterSearch(drink:))){
                  drink in
                  ListDrinkButtonView(drink: drink, drinkToAdd: self.$drinkToAdd, pressed: self.drinkToAdd.contains(drink.id) || self.user.userDrinks.contains(drink.id), showSheetDrinkInfo: self.$showDrinkInfo, infoDrink: self.$infoDrink)
                    .padding(.horizontal)

                }
              }
            }.padding(.top)
          }
          .gesture(DragGesture().onChanged { _ in
            UIApplication.shared.endEditing()
          })
          .padding(.top, 1)
        }

      }
      .navigationBarTitle("Drinks")

      HalfModalView(isShown: self.$showDrinkInfo){
        DrinkInfoView(showDrinkInfo: self.$showDrinkInfo, infoDrink: self.$infoDrink, mainCabinet: false)

      }

      HalfModalView(isShown: self.$showEditCategoriesOrListSheet, modalHeight: 200){
        EditCategoriesOrListView(isShown: self.$showEditCategoriesOrListSheet, categoriesOrList: self.$categoriesOrList)
      }
    }
  }
}

struct DrinkList_Previews: PreviewProvider {
  static var previews: some View {
    DrinkList(categoriesOrList: "Category")
  }
}


struct EditCategoriesOrListView: View {
  @Binding var isShown:Bool
  @Binding var categoriesOrList:String

  @EnvironmentObject var user:User
  @Environment(\.managedObjectContext) var managedObjectContext

  var body: some View {
    VStack{
      XButton(isShown: self.$isShown).padding(.bottom)


      Divider()
      EditCategoriesOrListButton(label: "Categories", categoriesOrList: self.$categoriesOrList)
      Divider()
      EditCategoriesOrListButton(label: "List", categoriesOrList: self.$categoriesOrList)
      Spacer()

    }.padding(.top)
  }
}


struct EditCategoriesOrListButton: View {
  let label: String
  @Binding var categoriesOrList:String

  @Environment(\.managedObjectContext) var managedObjectContext
  @EnvironmentObject var user:User

  var body: some View{
    Button(action: {
      self.categoriesOrList = label
      self.user.drinksViewPriority  = label
      AppDelegate.staticSaveContext(context: managedObjectContext)
    }, label: {
      HStack{
        Text("\(label) view").foregroundColor(.primary)
        Spacer()
        if (self.categoriesOrList == label){
          Image(systemName: "checkmark.circle.fill").foregroundColor(.red)
        } else {
          Image(systemName: "circle").foregroundColor(.primary).opacity(0.8)
        }
      }
    })
  }
}
