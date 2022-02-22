# frozen_string_literal: true

class Ckeditor::ApplicationController < Ckeditor.parent_controller.constantize
  layout Ckeditor.controller_layout

  before_action :find_asset, only: [:destroy]
  before_action :ckeditor_authorize!
  before_action :authorize_resource

  protected

  def respond_with_asset(asset)
    asset_response = Ckeditor::AssetResponse.new(asset, request)
    asset.data = asset_response.data
    puts asset.inspect
    if asset.save
      puts "\n\nSAVING THE ASSET\n\n"
      render asset_response.success(config.relative_url_root)
    else
      puts "\n\nCOULDNT SAVE THE ASSET\n\n"
      render asset_response.errors
    end
  end
end
