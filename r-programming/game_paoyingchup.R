game_pao <- function(){
  print("Welcome to the Game!!")
  
  # กำหนดตัวเลือกสำหรับเกม
  options <- c("paper", "hammer", "scissor", "quit")
  
  # กำหนดตัวแปรนับคะแนนเกม
  win <- 0
  y_lost <- 0
  deal <- 0
  
  # สร้างตัวแปรนับการเลือกของคอมพิวเตอร์และผู้เล่น สำหรับตัวเลือก "paper", "hammer", "scissor"
  com_count <- c(paper = 0, hammer = 0, scissor = 0)
  user_count <- c(paper = 0, hammer = 0, scissor = 0)
  
  repeat {
    # คัดเลือกการเล่นของคอมพิวเตอร์ (เลือกเฉพาะ 3 ตัวเลือกแรก)
    com_hand <- sample(options[1:3], 1)
    # นับการเลือกของคอมพิวเตอร์
    com_count[com_hand] <- com_count[com_hand] + 1
    
    # รวบรวมการเล่นของผู้ใช้
    user_play <- readline("Choose one of your options: paper, hammer, scissor or quit: ")
    
    # ตรวจสอบว่าผู้เล่นพิมพ์ quit หรือไม่
    if(user_play == "quit"){
      print("Thank you for playing!")
      print(paste("Score - Wins:", win, " | Losses:", y_lost, " | Deals:", deal))
      print("Computer selection counts:")
      print(com_count)
      print("Your selection counts:")
      print(user_count)
      break  # หยุดลูปและออกจากฟังก์ชัน
    }
    
    # ตรวจสอบ input ของผู้ใช้ว่าถูกต้องหรือไม่
    if(!(user_play %in% options)){
      print("Invalid input. Please choose paper, hammer, scissor or quit.")
      next  # ข้ามการเล่นรอบนี้แล้ววนใหม่
    }
    
    # นับการเลือกของผู้เล่น (สำหรับตัวเลือกที่เล่นจริง ๆ)
    if(user_play %in% c("paper", "hammer", "scissor")){
      user_count[user_play] <- user_count[user_play] + 1
    }
    
    # ตัดสินผู้ชนะตามกติกา
    if(com_hand == "hammer" && user_play == "paper"){
      winner <- "paper"
      what_win <- "You Win!"
      win <- win + 1
    } else if(com_hand == "hammer" && user_play == "scissor"){
      winner <- "hammer"
      what_win <- "You Lost!"
      y_lost <- y_lost + 1
    } else if(com_hand == "hammer" && user_play == "hammer"){
      winner <- "Deal"
      what_win <- "You Deal!"
      deal <- deal + 1
    } else if(com_hand == "paper" && user_play == "hammer"){
      winner <- "paper"
      what_win <- "You Lost!"
      y_lost <- y_lost + 1
    } else if(com_hand == "paper" && user_play == "scissor"){
      winner <- "scissor"
      what_win <- "You Win!"
      win <- win + 1
    } else if(com_hand == "paper" && user_play == "paper"){
      winner <- "Deal"
      what_win <- "You Deal!"
      deal <- deal + 1
    } else if(com_hand == "scissor" && user_play == "paper"){
      winner <- "scissor"
      what_win <- "You Lost!"
      y_lost <- y_lost + 1
    } else if(com_hand == "scissor" && user_play == "hammer"){
      winner <- "hammer"
      what_win <- "You Win!"
      win <- win + 1
    } else if(com_hand == "scissor" && user_play == "scissor"){
      winner <- "Deal"
      what_win <- "You Deal!"
      deal <- deal + 1
    } else {
      winner <- "No winner determined due to error in input."
      what_win <- ""
    }
    
    # แสดงผลการเล่นและผลลัพธ์
    print(paste("Computer played:", com_hand))
    print(paste("You played:", user_play))
    print(paste("OP Winner:", winner))
    print(paste("Result:", what_win))
  }
}
