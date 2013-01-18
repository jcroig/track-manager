package com.trackmanager

import org.springframework.dao.DataIntegrityViolationException

class EstimationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [estimationInstanceList: Estimation.list(params), estimationInstanceTotal: Estimation.count()]
    }

    def create() {
        [estimationInstance: new Estimation(params)]
    }

    def save() {
        def estimationInstance = new Estimation(params)
        if (!estimationInstance.save(flush: true)) {
            render(view: "create", model: [estimationInstance: estimationInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'estimation.label', default: 'Estimation'), estimationInstance.id])
        redirect(action: "show", id: estimationInstance.id)
    }

    def show(Long id) {
        def estimationInstance = Estimation.get(id)
        if (!estimationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'estimation.label', default: 'Estimation'), id])
            redirect(action: "list")
            return
        }

        [estimationInstance: estimationInstance]
    }

    def edit(Long id) {
        def estimationInstance = Estimation.get(id)
        if (!estimationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'estimation.label', default: 'Estimation'), id])
            redirect(action: "list")
            return
        }

        [estimationInstance: estimationInstance]
    }

    def update(Long id, Long version) {
        def estimationInstance = Estimation.get(id)
        if (!estimationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'estimation.label', default: 'Estimation'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (estimationInstance.version > version) {
                estimationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'estimation.label', default: 'Estimation')] as Object[],
                          "Another user has updated this Estimation while you were editing")
                render(view: "edit", model: [estimationInstance: estimationInstance])
                return
            }
        }

        estimationInstance.properties = params

        if (!estimationInstance.save(flush: true)) {
            render(view: "edit", model: [estimationInstance: estimationInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'estimation.label', default: 'Estimation'), estimationInstance.id])
        redirect(action: "show", id: estimationInstance.id)
    }

    def delete(Long id) {
        def estimationInstance = Estimation.get(id)
        if (!estimationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'estimation.label', default: 'Estimation'), id])
            redirect(action: "list")
            return
        }

        try {
            estimationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'estimation.label', default: 'Estimation'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'estimation.label', default: 'Estimation'), id])
            redirect(action: "show", id: id)
        }
    }
}
