require 'csv'

class EmployeesController < ApplicationController
  before_action :set_employee, only: %i(edit update destroy)
  before_action :set_form_option, only: %i(new create edit update)
  before_action :set_q, only: [:index]
  # rubocop:disable all
  def index
    @employees = @q.result.active.order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv do |csv|
        send_employees_csv(@employees)
      end
    end
  end
  # rubocop:enable all

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_url, notice: "社員「#{@employee.last_name} #{@employee.first_name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to employees_url, notice: "社員「#{@employee.last_name} #{@employee.first_name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      now = Time.now
      @employee.update_column(:deleted_at, now)
      @employee.profiles.active.first.update_column(:deleted_at, now) if @employee.profiles.active.present?
    end

    redirect_to employees_url, notice: "社員「#{@employee.last_name} #{@employee.first_name}」を削除しました。"
  end

  def send_employees_csv(employees)
    bom = "\uFEFF"
    csv_data = CSV.generate(bom) do |csv|
      header = %w(id 氏名(姓) 氏名(名) 社員番号 部署 オフィス アカウント メールアドレス)
      csv << header

      employees.each do |employee|
        values = [employee.id, employee.last_name, employee.first_name, employee.number, employee.department.name, employee.office.name, employee.account, employee.email]
        csv << values
      end
    end
    time_now = Time.zone.now.strftime('%Y%m%d%H%M%S')
    send_data(csv_data, filename: "employees_#{time_now}.csv", type: :csv)
  end

  private

  def employee_params
    params.require(:employee).permit(:number, :last_name, :first_name, :account, :password, :department_id, :office_id, :employee_info_manage_auth, :email, :date_of_joining, :news_posting_auth)
  end

  def set_employee
    @employee = Employee.find(params["id"])
  end

  def set_form_option
    @departments = Department.all
    @offices = Office.all
  end

  def set_q
    @q = Employee.ransack(params[:q])
  end

  def sort_column
    params[:sort] ? params[:sort] : 'number'
  end

  def sort_direction
    params[:direction] ? params[:direction] : 'asc'
  end
end
