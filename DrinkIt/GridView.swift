//
//  GridView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 15/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

//import SwiftUI
//
//struct GridView: View {
//
//    var row:Int
//    var col:Int
//    var array:[String]
//    var x:Int
//
//
//        var body: some View{
//         ScrollView(.horizontal) {
//                            VStack {
//                                ForEach(0..<self.row,  id: \.self){ i in
//                                    HStack{
//                                        ForEach(0..<self.col){ j in
//                                            if (i*3+j < x){
//                                                    Button(action: {
//
//                                                    }) {
//                                                        HStack{
//                                                            Text(self.array[i*3+j])
//                                                            Spacer()
//                                                //        ImageView()
//                                                        }
//                                                    }
//
//                                            }
//                                        }
//                                    }
//
//                                }
//
//                                }.padding()
//                        }
//    }
//
//}

//struct GridView_Previews: PreviewProvider {
//    static var previews: some View {
//        GridView()
//    }
//}
