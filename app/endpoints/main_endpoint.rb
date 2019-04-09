module MainEndpoint
  def self.list(route)
    -> {
      route.scope "(:locale)", locale: /en|id/ do
        route.root 'admin/dashboards#index'
        route.devise_for :users, path: 'admin', path_names: { sign_in: 'login', sign_out: 'logout' }

        route.namespace :admin do
          route.root 'dashboards#index'
          route.get 'schedules', to: 'pages#schedules'

          route.resources :customers
          route.resources :vendors
          route.resources :categories, except: :show
          route.resources :taxes, except: :show
          route.resources :products do
            route.member do
              route.resources :image_products, only: [:create, :destroy]
            end

            route.collection do
              route.get 'available', to: 'products#available'
              route.get 'unavailable', to: 'products#unavailable'
              route.get 'in-review', to: 'products#in_review'
            end
          end

          route.resources :invoices do
            route.member do
              route.resources :downloads, only: [:show]

              route.patch 'waiting-payment', to: 'invoices#update_to_waiting_payment'
              route.patch 'in-process', to: 'invoices#update_to_in_process'
              route.patch 'in-shipping', to: 'invoices#update_to_in_shipping'
              route.patch 'completed', to: 'invoices#update_to_completed'
              route.patch 'cancel', to: 'invoices#update_to_cancel'
            end

            route.collection do
              route.get 'pending', to: 'invoices#pending'
              route.get 'waiting-payment', to: 'invoices#waiting_payment'
              route.get 'in-process', to: 'invoices#in_process'
              route.get 'in-shipping', to: 'invoices#in_shipping'
              route.get 'completed', to: 'invoices#completed'
              route.get 'cancel', to: 'invoices#cancel'
            end
          end

          route.resources :purchases do
            route.member do
              route.resources :download_purchases, only: [:show]

              route.patch 'waiting-payment', to: 'invoices#update_to_waiting_payment'
              route.patch 'in-process', to: 'purchases#update_to_in_process'
              route.patch 'in-shipping', to: 'purchases#update_to_in_shipping'
              route.patch 'completed', to: 'purchases#update_to_completed'
              route.patch 'cancel', to: 'purchases#update_to_cancel'
            end

            route.collection do
              route.get 'pending', to: 'purchases#pending'
              route.get 'waiting-payment', to: 'purchases#waiting_payment'
              route.get 'in-process', to: 'purchases#in_process'
              route.get 'in-shipping', to: 'purchases#in_shipping'
              route.get 'completed', to: 'purchases#completed'
              route.get 'cancel', to: 'purchases#cancel'
            end
          end

          route.resources :payments do
            route.member do
              route.resources :download_payments, only: [:show]
              route.get 'paid-partially-modal', to: 'payments#paid_partially_modal'
              route.patch 'confirmed', to: 'payments#update_to_confirmed'
              route.patch 'paid-partially', to: 'payments#update_to_paid_partially'
              route.patch 'cancel', to: 'payments#update_to_cancel'
            end

            route.collection do
              route.get 'confirmed', to: 'payments#confirmed'
              route.get 'paid-partially', to: 'payments#paid_partially'
              route.get 'cancel', to: 'payments#cancel'
            end
          end

          route.resources :recurring_events
          route.resources :events
          route.resources :company_infos, only: [:index, :edit, :update]
          route.resources :payment_types, except: :show
          route.resources :brands, except: :show
          route.resources :couriers, except: :show
          route.resources :units, except: :show

          route.namespace :reports do
            route.get 'all', to: 'report_pages#index'

            route.get 'invoices', to: 'invoices#invoices'
            route.get 'pending-invoices', to: 'invoices#pending_invoices'
            route.get 'waiting-payment-invoices', to: 'invoices#waiting_payment_invoices'
            route.get 'in-process-invoices', to: 'invoices#in_process_invoices'
            route.get 'completed-invoices', to: 'invoices#completed_invoices'
            route.get 'cancel-invoices', to: 'invoices#cancel_invoices'

            route.get 'payments', to: 'payments#payments'
            route.get 'paid-partially-payments', to: 'payments#paid_partially_payments'
            route.get 'confirmed-payments', to: 'payments#confirmed_payments'
            route.get 'cancel-payments', to: 'payments#cancel_payments'
          end
        end
      end
    }.()
  end
end