class LineItemsController < ApplicationController

  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @line_items }
    end
  end


  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @line_item }
    end
  end


  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @line_item }
    end
  end


  def edit
    @line_item = LineItem.find(params[:id])
  end


  def create

    @cart = current_cart
    product = Product.find(params[:product_id])
    raise params[:product_id].inspect
    #@line_item = @cart.line_items.build(:product => product)
    @line_item = @cart.add_product(product.id)
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @cart, :notice => 'Line item was successfully created.' }
        format.json { render :json => @line_item, :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        format.json { render :json => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, :notice => 'Line item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.json { head :ok }
    end
  end

end
