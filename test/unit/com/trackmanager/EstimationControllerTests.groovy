package com.trackmanager



import org.junit.*
import grails.test.mixin.*

@TestFor(EstimationController)
@Mock(Estimation)
class EstimationControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/estimation/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.estimationInstanceList.size() == 0
        assert model.estimationInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.estimationInstance != null
    }

    void testSave() {
        controller.save()

        assert model.estimationInstance != null
        assert view == '/estimation/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/estimation/show/1'
        assert controller.flash.message != null
        assert Estimation.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/estimation/list'

        populateValidParams(params)
        def estimation = new Estimation(params)

        assert estimation.save() != null

        params.id = estimation.id

        def model = controller.show()

        assert model.estimationInstance == estimation
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/estimation/list'

        populateValidParams(params)
        def estimation = new Estimation(params)

        assert estimation.save() != null

        params.id = estimation.id

        def model = controller.edit()

        assert model.estimationInstance == estimation
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/estimation/list'

        response.reset()

        populateValidParams(params)
        def estimation = new Estimation(params)

        assert estimation.save() != null

        // test invalid parameters in update
        params.id = estimation.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/estimation/edit"
        assert model.estimationInstance != null

        estimation.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/estimation/show/$estimation.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        estimation.clearErrors()

        populateValidParams(params)
        params.id = estimation.id
        params.version = -1
        controller.update()

        assert view == "/estimation/edit"
        assert model.estimationInstance != null
        assert model.estimationInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/estimation/list'

        response.reset()

        populateValidParams(params)
        def estimation = new Estimation(params)

        assert estimation.save() != null
        assert Estimation.count() == 1

        params.id = estimation.id

        controller.delete()

        assert Estimation.count() == 0
        assert Estimation.get(estimation.id) == null
        assert response.redirectedUrl == '/estimation/list'
    }
}
