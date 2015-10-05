module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :faqs do
      desc "Return all FAQs"
      get do
        faqs = Array.new

        # Prepare conditions based on params
        valid_params = {
          tags: 'tags'
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        Faq.where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |faq|
            faqs << {
              id: faq.id,
              question_text: faq.question_text,
              relevant_laws_regulations: faq.relevant_laws_regulations,
              relevant_text: faq.relevant_text,
              question_answer: faq.question_answer,
              tags: faq.tags,
              category: faq.category
            }
        end

        {
          results: {
            count: faqs.count,
            total: Faq.where(conditions).count,
            faqs: faqs
          }
        }
      end
    end

    resources :tags do
      desc  "Return all Tags of FAQs"
      get do
        tags = Array.new

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]
        
        Tag.limit(limit)
          .offset(params[:offset])
          .each do |tag|
            tags << {
              id: tag.id,
              name: tag.name
            }
        end

        {
          results: {
            count: tags.count,
            total: Tag.count,
            tags: tags
          }
        }
      end
    end
  end
end