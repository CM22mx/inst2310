view: employees {
  sql_table_name: demo_db.Employees ;;

  dimension: emp_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.EmpID ;;
  }
  dimension: manager {
    type: number
    sql: ${TABLE}.Manager ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.Name ;;
  }
  measure: count {
    type: count
    drill_fields: [name]
  }
  measure: sumEmp {
    type: sum
    sql: ${TABLE}.EmpID;;
  }
}
