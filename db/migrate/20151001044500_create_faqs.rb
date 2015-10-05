class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.text 	:question_text	
      t.text 	:relevant_laws_regulations	
      t.text 	:relevant_text	
      t.text 	:question_answer	
      t.string 	:tags	
      t.string 	:category
      t.timestamps
    end
  end
end
